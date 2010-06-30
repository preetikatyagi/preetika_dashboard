class ActiveRecord::Base
	
	def node_id
		self.class.name + self.id.to_s
	end
	
end