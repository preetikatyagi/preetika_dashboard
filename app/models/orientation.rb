class Orientation < ActiveRecord::Base

	has_many	:concepts

	validates_presence_of	:name

end
