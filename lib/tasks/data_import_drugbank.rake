# require 'csv'
require 'net/http'

namespace :data do

	namespace :import do
		
		# desc "Downloads and uncompresses the latest complete DrugBank package."
		# task :drugbank_download do
		# 	url = 'http://www.drugbank.ca/public/downloads/current/drugcards.zip'
		# end
		
	  desc 'Imports DrugCard data, if present.'
	  task :drugbank => :environment do
		file = File.expand_path('../../../public/data/drugcards.txt',  __FILE__)
		drugbank_import(file)
		end

	desc 'Import a subset of the DrugBank database, for quick testing purposes.'
	  task :drugbank_test => :environment do
		file = File.expand_path('../../../public/data/drugcards.test.txt',  __FILE__)
		drugbank_import(file)
	end
	
	# As of early April, 2010, the unique values of the "Drug_Type" field in the actual data are..
	# >> Drug.all.collect{|d| d.drug_type}.uniq.sort!.each do |d| puts d end
	# 				Approved Biotech
	# 				Approved Biotech Investigational
	# 				Approved Biotech Investigational Withdrawn
	# 				Approved Biotech Withdrawn
	# 				Approved Illicit Investigational Small Molecule
	# 				Approved Illicit Small Molecule
	# 				Approved Illicit Small Molecule Withdrawn
	# 				Approved Investigational Nutraceutical Small Molecule
	# 				Approved Investigational Small Molecule
	# 				Approved Investigational Small Molecule Withdrawn
	# 				Approved Nutraceutical Small Molecule
	# 				Approved Nutraceutical Small Molecule Withdrawn
	# 				Approved Small Molecule
	# 				Approved Small Molecule Withdrawn
	# 				Biotech
	# 				Experimental Illicit Small Molecule
	# 				Experimental Illicit Small Molecule Withdrawn
	# 				Experimental Investigational Small Molecule
	# 				Experimental Nutraceutical Small Molecule
	# 				Experimental Small Molecule
	# 				Experimental Small Molecule Withdrawn
	# 				Illicit Small Molecule Withdrawn
	# 				Investigational Small Molecule Withdrawn
	# 				Nutraceutical Small Molecule
	# 				Small Molecule Withdrawn
	#
	# We only care about Approved, Experimental and Biotech drug types with an ATC classification code containing an "L".
	def should_import_drugcard(data)
		ok_type = data['Drug_Type'] =~ /(Approved)|(Experimental)|(Biotech)/
		ok_atc = !data['ATC_Codes'].nil? && data['ATC_Codes'].include?('L')
		ok_type && ok_atc
	end

	def populate_drug_fields(d, data)
		d.name = data['Generic_Name'] || "Unknown Name" # We'll reuse this field.
		d.brand_names = data['Brand_Names']
		d.generic_names = data['Generic_Name']
		d.description = data['Description']
		# d.biotransformation = data['Biotransformation'] # No longer wanted.
		# d.external_id = id
		d.drug_type = data['Drug_Type']
		d.chemical_formula = data['Chemical_Formula']
		d.absorption = data['Absorption']
		d.drug_interactions = data['Drug_Interactions']
		# d.half_life = data['Half_Life'] # No longer wanted.
		d.kegg_drug_id = data['KEGG_Drug_ID']
		d.lims_drug_id = data['LIMS_Drug_ID']
		d.pubchem_compound_id = data['PubChem_Compound_ID']
		d.pubchem_substance_id = data['PubChem_Substance_ID']
		d.url = data['Wikipedia_Link']
		d.genbank_id = data['GenBank_ID']
		d.dpd_drug_id = data['DPD_Drug_ID_Number']

		d.primary_accession_number = data['Primary_Accession_No']
		d.secondary_accession_number = data['Secondary_Accession_No']
		d.chemical_iupac_name = data['Chemical_IUPAC_Name']
		d.cas_registry_number = data['CAS_Registry_Number']
		d.kegg_compound_id = data['KEGG_Compound_ID']
		d.chebi_id = data['ChEBI_ID']
		d.rxlist_link = data['RxList_Link']
		d.pharm_gkb_id = data['PharmGKB_ID']
		d.pdrhealth_link = data['PDRhealth_Link']
		d.wikipedia_link = data['Wikipedia_Link']
		d.drug_category = data['Drug_Category']
		d.pharmacology = data['Pharmacology']
		d.mechanism_of_action = data['Mechanism_Of_Action']
		d.indication = data['Indication']
		d.atc_codes = data['ATC_Codes']
		d
	end
	
	def drugbank_import(file)
		# Find the presumably pre-defined data source.
		code = 'drugbank'
		source = Source.find_by_code(code)
		# If it doesn't exist, create it!
		if source.nil?
			puts "Creating new data source record..."
			source = Source.new
			source.code = code
			source.name = 'DrugBank'
			source.url = 'http://drugbank.ca'
			source.description = "The DrugBank database is a unique bioinformatics and cheminformatics resource that combines detailed drug (i.e. chemical, pharmacological and pharmaceutical) data with comprehensive drug target (i.e. sequence, structure, and pathway) information."
			source.save!
		else
			puts "Existing data source record found!"
		end		
		
		
		if !File.exist? file
			puts "File could not be found! (#{file})"
		else
			puts "Reading data file..."
			f = File.open(file, "r")
			raw = f.read
			
			# Seperate each card
			puts "Separating cards..."
			cards = raw.split(/^#BEGIN_DRUGCARD /)
			cards.shift # The first will be nil.
			
			added = 0
			updated = 0
			irrelevant = 0
			total = cards.length

			# Process each card.
			puts "Processing each card...  (may take a while)"
			cards.each do |c|
				lines = c.split("\n")
				external_id = lines.shift

				# Read all the fields
				data = {}
				current_field = nil
				line_number = 0
				lines.each do |line|
					line_number += 1
					 				case line
					# when nil
						# puts "#{line_number} Nil"
					 				when /^$/
						# puts "#{line_number} Nothing '#{line}'"
						current_field = nil
					when /^\#.*:$/
						# puts "#{line_number} Key '#{line}'"
						current_field = line[2..-2]
						data[current_field] = nil
					when /^#END_DRUGCARD.*$/
						current_field = nil
					when /^.+$/
						# puts "#{line_number} Value '#{line}'"
						if data[current_field] == nil
				   							data[current_field] = ''
						else
							data[current_field] += ' '
						end
						data[current_field] += line
					 				else # We don't care about this field
					 					# puts "#{line_number} EH??? '#{line}'"
					 				end
					 			end
					
				# Scrub any data this is "Not Available".
				data.keys.each do |k|
					if data[k] == 'Not Available'
						# puts 'Not Available'
						data.delete k
					end
				end
				# puts data				
				
				if should_import_drugcard(data)
					# puts external_id
					d = Drug.find_by_external_id(external_id)
					if d.nil?
						# puts 'NEW'
						d = Drug.new
						d.external_id = external_id
						existed = false
					else
						existed = true
					end
					
					# Create the drug record with the new data!
					d.source = source
					populate_drug_fields(d, data)
					d.save!
					if existed
						updated += 1
					else
						added += 1
					end
				else
					irrelevant += 1
				end # relevancy check
			end # card processing loop.
			
			puts "DrugCard import job statistics:"
			puts "  #{total} processed in total."
			puts "  #{irrelevant} were deemed irrelevant and were ignored."
			puts "  #{updated} already existed and were updated."
			puts "  #{added} added to the database."
		end
	  end
	end
	
	
end