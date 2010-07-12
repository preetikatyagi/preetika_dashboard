class WelcomeController < ApplicationController
	
		before_filter :login_required, :only => [:dashboard]

	def index
		render :layout => 'landing'  
	end
	
	def demo
		render :layout => 'demo'
	end
	# Added by Preetika Tyagi - begins
	def dashboard
	  @colorSequencer = '#996600'
	  @sequencer = 'Sequencer'
    @upload = Upload.new
    @delayed_jobs = DelayedJob.all
	  @autorefresh = true
	  @uploadID = '0'
	  @importID = '0'
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @delayed_jobs }
    end
  end
	# Added by Preetika Tyagi - ends
end
