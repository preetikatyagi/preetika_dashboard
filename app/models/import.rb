class Import < ActiveRecord::Base

	belongs_to	:format
	belongs_to	:patient, :class_name => 'User', :foreign_key => 'patient_id'
	belongs_to	:importer, :class_name => 'User', :foreign_key => 'importer_id'
	
	has_many	:uploads, :dependent => :destroy
  	has_many	:analyses #, :class_name => 'Analysis'
	# has_many	:mutations, :dependent => :destroy

	validates_presence_of	:patient
	validates_presence_of	:importer

	def name
		"##{self.id} (Patient: #{self.patient.name}. Importer: #{self.importer.name})"
	end

end
