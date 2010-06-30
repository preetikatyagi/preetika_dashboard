class Source < ActiveRecord::Base
	
	has_many	:drugs, :dependent => :destroy
	has_many	:concepts
  
	validates_presence_of :name
	validates_presence_of :description
	validates_presence_of :url
	
end
