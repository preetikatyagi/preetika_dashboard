class WelcomeController < ApplicationController
	
		before_filter :login_required, :only => [:dashboard]

	def index
		render :layout => 'landing'  
	end
	
	def demo
		render :layout => 'demo'
	end
	# Added by Preetika Tyagi
	def dashboard
	  @colorSequencer = '#996600'
	  @sequencer = 'Sequencer'
    @upload = Upload.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
    end
  end
	
end
