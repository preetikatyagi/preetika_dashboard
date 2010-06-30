class SubconceptsController < ApplicationController
  # GET /subconcepts
  # GET /subconcepts.xml
  def index
    @subconcepts = Subconcept.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subconcepts }
    end
  end

  # GET /subconcepts/1
  # GET /subconcepts/1.xml
  def show
    @subconcept = Subconcept.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subconcept }
    end
  end

  # GET /subconcepts/new
  # GET /subconcepts/new.xml
  def new
    @subconcept = Subconcept.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subconcept }
    end
  end

  # GET /subconcepts/1/edit
  def edit
    @subconcept = Subconcept.find(params[:id])
  end

  # POST /subconcepts
  # POST /subconcepts.xml
  def create
    @subconcept = Subconcept.new(params[:subconcept])

    respond_to do |format|
      if @subconcept.save
        flash[:notice] = 'Subconcept was successfully created.'
        format.html { redirect_to(@subconcept.parent) }
        format.xml  { render :xml => @subconcept, :status => :created, :location => @subconcept }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subconcept.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subconcepts/1
  # PUT /subconcepts/1.xml
  def update
    @subconcept = Subconcept.find(params[:id])

    respond_to do |format|
      if @subconcept.update_attributes(params[:subconcept])
        flash[:notice] = 'Subconcept was successfully updated.'
        format.html { redirect_to(@subconcept) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subconcept.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subconcepts/1
  # DELETE /subconcepts/1.xml
  def destroy
    @subconcept = Subconcept.find(params[:id])
    @subconcept.destroy

    respond_to do |format|
      format.html { redirect_to(subconcepts_url) }
      format.xml  { head :ok }
    end
  end
end
