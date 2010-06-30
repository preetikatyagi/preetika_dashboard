class Role < ActiveRecord::Base

  has_and_belongs_to_many :users

validates_presence_of	:code
validates_presence_of	:name

	validates_uniqueness_of	:code
	validates_uniqueness_of	:name
	
	def users_including_admins()
		users | Role.find_by_code('admin').users
	end
	
end