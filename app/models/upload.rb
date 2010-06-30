class Upload < ActiveRecord::Base
	
	belongs_to	:import
	
	has_many :samples, :dependent => :destroy

	validates_presence_of	:import
	
    has_attached_file :data #, :styles => { :medium => "300x300>", :thumb => "100x100>" 


	def unlink_samples_to_genes()
		# Sample.destroy_all(['upload_id = ?', self.id])
		Sample.update_all("gene_id = null", ['upload_id = ?', self.id])
	end
	
  
  def link_samples_to_genes(create_missing = false)
    count = Sample.count(:conditions => ['gene_id IS NULL AND upload_id = ?', self.id])
	puts "Attempting to link #{count} samples for upload ##{self.id}."
	created = 0
	linked = 0
	skipped = 0
	start = Time.now
	more = true
	offset = 0
	batch = 200
	while more
		samples = Sample.find(:all, :conditions => ['upload_id = ? AND gene_id IS NULL', self.id], :limit => batch, :offset => offset)
		offset += batch
		more = false if samples.size < 1
		Sample.transaction do
			samples.each do |s|
				h = s.ensembl_id
			  	g = Gene.first(:conditions => ['ensembl_id = ?', h])
				if g.nil?
					if create_missing
						# We'll create the gene record first.
						g = Gene.new
						g.ensembl_id = h
						g.save!
						created += 1
						# Now link it to the sample!
						s.gene = g
						s.save!
						linked += 1
					else
						skipped += 1
					end
				else
					s.gene = g
					s.save!
					linked += 1
				end
			end
		end
	end
	finish = Time.now
	puts "Genes records created in the process: #{created}"
	puts "Samples linked to gene records: #{linked}"
	puts "Samples skipped due to missing gene record: #{skipped}"
	puts "Total Time: #{finish - start}"
  end

end
