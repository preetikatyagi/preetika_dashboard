class UploadsController < ApplicationController
	
	before_filter :login_required
	

	def link_samples_to_genes
		@upload = Upload.find(params[:id])
		Delayed::Job.enqueue UploadSampleGeneLinkJob.new(@upload.id)
		flash[:info] = "The system will attempt to link samples from upload ##{@upload.id} to gene records shortly. It may take a while."
		if params[:analysis_id]
			redirect_to :controller => 'analyses', :action => 'show', :id => params[:analysis_id]
		else
			redirect_to :controller => 'uploads', :action => 'show', :id => @upload.id
		end
	end

	def unlink_samples_to_genes
		@upload = Upload.find(params[:id])
		Delayed::Job.enqueue UploadSampleGeneUnlinkJob.new(@upload.id)
		flash[:info] = "The system will attempt to unlink sample gene references from upload ##{@upload.id} shortly. It may take a while."
		if params[:analysis_id]
			redirect_to :controller => 'analyses', :action => 'show', :id => params[:analysis_id]
		else
			redirect_to :controller => 'uploads', :action => 'show', :id => @upload.id
		end
	end

		
  # GET /uploads
  # GET /uploads.xml
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
  end

  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload }
    end
  end

  def samples
	id = params[:id]
	page = params[:page] || 1
    @upload = Upload.find(id)
    @samples = Sample.paginate(:conditions => ['upload_id = ? AND gene_id IS NOT NULL', id], :include => [:gene, :zygosity], :page => page, :per_page => 30)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @samples }
    end
  end


  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.xml
  def create
    @upload = Upload.new(params[:upload])

    respond_to do |format|
      if @upload.save
		Delayed::Job.enqueue UploadProcessorJob.new(@upload.id)
        flash[:notice] = 'Upload was successfully created. It will be processed in the background automatically.'
        format.html { redirect_to(@upload) }
        format.xml  { render :xml => @upload, :status => :created, :location => @upload }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @upload = Upload.find(params[:id])
	rp = params[:upload].delete(:reprocess)
    respond_to do |format|
		puts params
      if @upload.update_attributes(params[:upload])
		if rp
			job = UploadProcessorJob.new(@upload.id)
			Delayed::Job.enqueue job
		end
        flash[:notice] = 'Upload was successfully updated.'
        format.html { redirect_to(@upload) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html {
		#redirect_to(uploads_url)
		redirect_to :back}
      format.xml  { head :ok }
    end
  end
end
