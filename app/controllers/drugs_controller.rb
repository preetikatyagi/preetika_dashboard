#require 'fastercsv'

class DrugsController < ApplicationController
	
	before_filter :login_required, :except => [:index]

	# TODO Finish migrating from FasterCSV to the Ruby 1.9 implementation.
	# def antineoplastics
	# 	respond_to do |format|
	#     	format.csv {
	# 			csv_string = FasterCSV.generate do |csv|
	#     			# header row
	#     			csv << ["External ID", "Generic Names", "Drug Category", "Drug Category", "ChEBI", "PharmGKB"]
	# 				drugs = Drug.find(:all, :conditions => "drug_category LIKE '%Antineoplastic%'")
	# 				drugs.each do |d|
	# 					csv << [
	# 						d.external_id,
	# 						d.generic_names,
	# 						d.drug_type,
	# 						d.drug_category,
	# 						"http://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:#{d.chebi_id}",
	# 						"http://www.pharmgkb.org/views/index.jsp?objId=#{d.pharm_gkb_id}"
	# 						]
	# 				end
	#   			end
	# 
	#   			# send it to the browsah
	#   			send_data csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=users.csv"
	# 		}
	# 	end
	# end
	
  # GET /drugs
  # GET /drugs.xml
  def index
    respond_to do |format|
      format.html {
		page = params[:page] || 1
	    @drugs = Drug.paginate(:include => [:source], :order => 'name ASC', :page => page, :per_page => 10)
	}
      # format.xml  { render :xml => @drugs }
      format.json  {
		@drugs = Drug.all
		render :json => @drugs
		}
    end
  end
  
  # GET /drugs/1
  # GET /drugs/1.xml
  def show
    @drug = Drug.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @drug }
      format.json  { render :json => @drug }
    end
  end

  # GET /drugs/new
  # GET /drugs/new.xml
  def new
    @drug = Drug.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @drug }
    end
  end

  # GET /drugs/1/edit
  def edit
    @drug = Drug.find(params[:id])
  end

  # POST /drugs
  # POST /drugs.xml
  def create
    @drug = Drug.new(params[:drug])

    respond_to do |format|
      if @drug.save
        flash[:notice] = 'Drug was successfully created.'
        format.html { redirect_to(@drug) }
        format.xml  { render :xml => @drug, :status => :created, :location => @drug }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @drug.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /drugs/1
  # PUT /drugs/1.xml
  def update
    @drug = Drug.find(params[:id])

    respond_to do |format|
      if @drug.update_attributes(params[:drug])
        flash[:notice] = 'Drug was successfully updated.'
        format.html { redirect_to(@drug) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @drug.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /drugs/1
  # DELETE /drugs/1.xml
  def destroy
    @drug = Drug.find(params[:id])
    @drug.destroy

    respond_to do |format|
      format.html { redirect_to(drugs_url) }
      format.xml  { head :ok }
    end
  end
end
