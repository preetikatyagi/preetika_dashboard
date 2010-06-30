class WelcomeController < ApplicationController
	
		before_filter :login_required, :only => [:dashboard]

	def index
		render :layout => 'landing'  
	end
	
	def demo
		render :layout => 'demo'
	end
	
	def dashboard
		
	end
	
	
end
