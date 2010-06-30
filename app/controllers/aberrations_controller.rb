class AberrationsController < ApplicationController
  # GET /aberrations
  # GET /aberrations.xml
  def index
    @aberrations = Aberration.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aberrations }
    end
  end

  # GET /aberrations/1
  # GET /aberrations/1.xml
  def show
    @aberration = Aberration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aberration }
    end
  end

  # GET /aberrations/new
  # GET /aberrations/new.xml
  def new
    @aberration = Aberration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aberration }
    end
  end

  # GET /aberrations/1/edit
  def edit
    @aberration = Aberration.find(params[:id])
  end

  # POST /aberrations
  # POST /aberrations.xml
  def create
    @aberration = Aberration.new(params[:aberration])

    respond_to do |format|
      if @aberration.save
        flash[:notice] = 'Aberration was successfully created.'
        format.html { redirect_to(@aberration) }
        format.xml  { render :xml => @aberration, :status => :created, :location => @aberration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @aberration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aberrations/1
  # PUT /aberrations/1.xml
  def update
    @aberration = Aberration.find(params[:id])

    respond_to do |format|
      if @aberration.update_attributes(params[:aberration])
        flash[:notice] = 'Aberration was successfully updated.'
        format.html { redirect_to(@aberration) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @aberration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aberrations/1
  # DELETE /aberrations/1.xml
  def destroy
    @aberration = Aberration.find(params[:id])
    @aberration.destroy

    respond_to do |format|
      format.html { redirect_to(aberrations_url) }
      format.xml  { head :ok }
    end
  end
end
