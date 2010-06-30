class ZygositiesController < ApplicationController
  # GET /zygosities
  # GET /zygosities.xml
  def index
    @zygosities = Zygosity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @zygosities }
    end
  end

  # GET /zygosities/1
  # GET /zygosities/1.xml
  def show
    @zygosity = Zygosity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @zygosity }
    end
  end

  # GET /zygosities/new
  # GET /zygosities/new.xml
  def new
    @zygosity = Zygosity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @zygosity }
    end
  end

  # GET /zygosities/1/edit
  def edit
    @zygosity = Zygosity.find(params[:id])
  end

  # POST /zygosities
  # POST /zygosities.xml
  def create
    @zygosity = Zygosity.new(params[:zygosity])

    respond_to do |format|
      if @zygosity.save
        flash[:notice] = 'Zygosity was successfully created.'
        format.html { redirect_to(@zygosity) }
        format.xml  { render :xml => @zygosity, :status => :created, :location => @zygosity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @zygosity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /zygosities/1
  # PUT /zygosities/1.xml
  def update
    @zygosity = Zygosity.find(params[:id])

    respond_to do |format|
      if @zygosity.update_attributes(params[:zygosity])
        flash[:notice] = 'Zygosity was successfully updated.'
        format.html { redirect_to(@zygosity) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zygosity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /zygosities/1
  # DELETE /zygosities/1.xml
  def destroy
    @zygosity = Zygosity.find(params[:id])
    @zygosity.destroy

    respond_to do |format|
      format.html { redirect_to(zygosities_url) }
      format.xml  { head :ok }
    end
  end
end
