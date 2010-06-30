# require 'csv'

namespace :data do

	namespace :import do
	
		namespace :sample do
			
			@@CACHE = {}
			
			desc 'Import sample sequence file, if present.'
			task :sequence => :environment do
				file_name = File.expand_path('../../../public/data/sample.vcf',  __FILE__)
				# file_name = File.expand_path('../../../public/data/development/YRI.100328.chr1-22.annotate.txt',  __FILE__)
				if !File.exist? file_name
					puts "File could not be found! (#{file})"
				else
					counter = 0
					login = 'admin'
					puts "Finding '#{login}' to use as owner of new import package..."
					user = User.find_by_login login
					puts "Creating new import package..."
					i = Import.new
					i.patient = user
					i.importer = user
					i.save!
					puts "Creating new file upload record..."
					upload = Upload.new
					upload.import = i
					upload.save!
					puts "Importing sample data file... (will take a while)"
					
					p = UploadProcessor.new
					results = p.process_upload(upload, file_name)
					stop = Time.now
					puts "Import information:"
					puts "\t#{results[:samples]} samples."
					puts "\tImport ID:\t#{results[:import_id]}"
					puts "\tUpload ID:\t#{results[:upload_id]}"
					puts "\tTotal Time:\t#{results[:total_time]}"
					puts "\tRecords/Second: #{results[:rate]}"
				end
			end
			
		end
	
	end
	
end