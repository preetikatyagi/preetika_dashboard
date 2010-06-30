class Suggestion < ActiveRecord::Base

  	belongs_to  :analysis
	belongs_to  :treatment

	validates_presence_of	:analysis
	validates_presence_of	:treatment

end
