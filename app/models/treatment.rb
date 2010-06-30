class Treatment < ActiveRecord::Base

	belongs_to  :drug
	belongs_to  :concept
	
	has_many	:suggestions
	
	validates_presence_of :weight

	validates_numericality_of	:weight, :integer_only => true
  	validates_uniqueness_of	:drug_id, :scope => [:concept_id]

	def name
		"#{self.drug.name} for #{self.concept.name}"
	end
	
end
