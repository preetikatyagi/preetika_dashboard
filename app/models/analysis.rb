class Analysis < ActiveRecord::Base
	
	belongs_to	:import
	belongs_to	:analyst, :class_name => 'User', :foreign_key => 'analyst_id'
	
	has_many	:suggestions
	
	validates_presence_of	:import
	validates_presence_of	:analyst


	def name
		"##{self.id} by #{self.analyst.name}. (Patient: #{self.import.patient.name}, Import ID ##{self.import.id}.)"
	end

	def generate_suggestions
		puts "Generating suggestions for analysis ##{self.id}."
		import.uploads.each do |u|
			created = 0
			existed = 0
			puts "\tUpload ##{u.id}"
			more = true
			offset = 0
			batch = 200
			while more
				samples = Sample.all(:conditions => ['upload_id = ? AND gene_id IS NOT NULL', u.id], :limit => batch, :offset => offset)
				offset += batch
				if samples.size > 0
					Sample.transaction do 
						puts "\t\t#{samples.length} samples"
						samples.each do |s|
							g = s.gene
							g.members.each do |m|
								m.concept.treatments.each do |t|
									# puts "\t\tT!"
									exists = Suggestion.count(:conditions => ['analysis_id = ? AND treatment_id = ?', self.id, t.id])
									if exists > 0
										existed += 1
									else
										sug = Suggestion.new
										sug.treatment = t
										sug.analysis = self
										sug.save!
										created += 1
									end
								end
							end
						end
					end
				else
					more = false 
				end
			end
			puts "\t\tCreated: #{created}"
			puts "\t\tExisted: #{existed}"
		end
	end
	
end
