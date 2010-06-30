class Format < ActiveRecord::Base
	
	# has_many	:imports

	validates_presence_of	:name
	validates_presence_of	:file_suffix
	validates_presence_of	:mime_type

end
