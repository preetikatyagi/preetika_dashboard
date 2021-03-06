class ImportsController < ApplicationController
	
	before_filter :login_required
	
	# GET /imports
	# GET /imports.xml
	def index
		@imports = Import.all
		
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @imports }
		end
	end
	
	# GET /imports/1
	# GET /imports/1.xml
	def show
		@import = Import.find(params[:id])
		
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @import }
		end
	end
	
	# GET /imports/new
	# GET /imports/new.xml
	def new
		@import = Import.new
		
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @import }
		end
	end
	
	# GET /imports/1/edit
	def edit
		@import = Import.find(params[:id])
	end
	
	# POST /imports
	# POST /imports.xml
	def create
		@import = Import.new(params[:import])
		
		respond_to do |format|
			if @import.save
				flash[:notice] = 'Import was successfully created.'
				format.html { redirect_to(@import) }
				format.xml  { render :xml => @import, :status => :created, :location => @import }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @import.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# PUT /imports/1
	# PUT /imports/1.xml
	def update
		@import = Import.find(params[:id])
		
		respond_to do |format|
			if @import.update_attributes(params[:import])
				flash[:notice] = 'Import was successfully updated.'
				format.html { redirect_to(@import) }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @import.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# DELETE /imports/1
	# DELETE /imports/1.xml
	def destroy
		@import = Import.find(params[:id])
		@import.destroy
		
		respond_to do |format|
			format.html { redirect_to(imports_url) }
			format.xml  { head :ok }
		end
	end
end
