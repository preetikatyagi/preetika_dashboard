class Drug < ActiveRecord::Base


	belongs_to	:source
	has_many	:treatments, :dependent => :destroy

	validates_presence_of	:source
	validates_presence_of	:name
	
end
