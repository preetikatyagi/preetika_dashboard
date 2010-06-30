class UploadProcessor
			
			attr_accessor :cache
			
			def initialize
				self.cache = {}
			end

			def process_upload(upload, file_name)
				r = nil
				if !File.exist? file_name
					raise "File could not be found! (#{file_name})"
				else
					# Delete all existing samples associated with this upload to prevent data duplication.
					# We'll use raw SQL for speed.
					ActiveRecord::Base.connection.execute("DELETE FROM samples WHERE upload_id = #{upload.id}")
					counter = 0
					# Import data file... (will take a while)
					start = Time.now
					commit_pool = []
					# FasterCSV.foreach(file_name, :col_sep => "\t") do |row|
					CSV::Reader.parse(File.open(file_name), :fs => "\t") do |row|
						if counter > 0

							cache = {}
							chromosome = get_chromosome(row[0])
							sample_type = get_sample_type(row[03])
							zygosity = get_zygosity(row[18])
							
							# Clean out the "null" data from the row.
							for n in 0..(row.size - 1)
								case row[n]
								when '*'
									row[n] = nil
								when '-'
									row[n] = false
								when '+'
									row[n] = true
								else
									# Intentionally leave it alone!
								end
								# row[n] = sanitize_sql(row[n])
							end
							
							fields = []
							for n in 1..17 do
								next if n == 3
								if row[n]
									fields << "'#{row[n]}'"
								else
									fields << 'null'
								end
							end
							
							sql = "INSERT INTO samples (chromosome_id, upload_id, sample_type_id, zygosity_id, loc, gene_name, db_snp, ref_allele, snp_code, strand_add, depth, transcript_id, ensembl_id, start_codon_loc, dist_to_exon, codon_seq, old_aa, new_seqs, new_aa, ns_or_ss)" +
							" VALUES(#{chromosome.id}, #{upload.id}, #{sample_type.id}, #{zygosity.id}, #{fields.join(', ')});"
							# Instead of saving immediately, we'll batch up our stuff to commit to avoid creating N transactions.
							# s.save!
							
							commit_pool << sql
							if commit_pool.size > 1000
								commit_all(commit_pool)
								# GC.start # Doesn't seem to help performance.
								commit_pool = []
							end
						end
						# puts counter if counter % 1000 == 0
					    counter = counter + 1
					end
					commit_all(commit_pool)
					stop = Time.now
					
					r = {}
					r[:samples] = counter
					r[:total_time] = stop - start
					r[:rate] = counter / (stop - start)
				end
				return r
			end
			
			def get_chromosome(code)
				self.cache[:chromosome] = {} if self.cache[:chromosome].nil?
				c = self.cache[:chromosome][code]
				if c.nil?
					c = Chromosome.find_by_import_code code
					if c.nil?
						c = Chromosome.new
						c.import_code = code
						c.number = code.sub('chr', '').to_i
						c.save!
					end
					self.cache[:chromosome][code] = c
				end
				c
			end
			
			def get_zygosity(code)
				self.cache[:zygosity] = {} if self.cache[:zygosity].nil?
				z = self.cache[:zygosity][code]
				if z.nil?
					z = Zygosity.find_by_import_code code
					if z.nil?
						z = Zygosity.new
						z.import_code = code
						z.save!
					end
					self.cache[:zygosity][code] = z
				end
				z
			end
			
			
			def get_sample_type(code)
				self.cache[:sample_type] = {} if self.cache[:sample_type].nil?
				z = self.cache[:sample_type][code]
				if z.nil?
					z = SampleType.find_by_import_code code
					if z.nil?
						z = SampleType.new
						z.import_code = code
						z.save!
					end
					self.cache[:sample_type][code] = z
				end
				z
			end
			
			
			def commit_all(commit_pool)
				ActiveRecord::Base.transaction do
					commit_pool.each do |x|
						ActiveRecord::Base.connection.execute(x)
						# x.save
					end
				end	
			end
			
		end