class ChromosomesController < ApplicationController
  # GET /chromosomes
  # GET /chromosomes.xml
  def index
    @chromosomes = Chromosome.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chromosomes }
    end
  end

  # GET /chromosomes/1
  # GET /chromosomes/1.xml
  def show
    @chromosome = Chromosome.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chromosome }
    end
  end

  # GET /chromosomes/new
  # GET /chromosomes/new.xml
  def new
    @chromosome = Chromosome.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chromosome }
    end
  end

  # GET /chromosomes/1/edit
  def edit
    @chromosome = Chromosome.find(params[:id])
  end

  # POST /chromosomes
  # POST /chromosomes.xml
  def create
    @chromosome = Chromosome.new(params[:chromosome])

    respond_to do |format|
      if @chromosome.save
        flash[:notice] = 'Chromosome was successfully created.'
        format.html { redirect_to(@chromosome) }
        format.xml  { render :xml => @chromosome, :status => :created, :location => @chromosome }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chromosome.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chromosomes/1
  # PUT /chromosomes/1.xml
  def update
    @chromosome = Chromosome.find(params[:id])

    respond_to do |format|
      if @chromosome.update_attributes(params[:chromosome])
        flash[:notice] = 'Chromosome was successfully updated.'
        format.html { redirect_to(@chromosome) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chromosome.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chromosomes/1
  # DELETE /chromosomes/1.xml
  def destroy
    @chromosome = Chromosome.find(params[:id])
    @chromosome.destroy

    respond_to do |format|
      format.html { redirect_to(chromosomes_url) }
      format.xml  { head :ok }
    end
  end
end
