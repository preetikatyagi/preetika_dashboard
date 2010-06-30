class Zygosity < ActiveRecord::Base

	has_many	:samples
	
	validates_presence_of	:import_code

end
