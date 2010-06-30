class SearchController < ApplicationController
	
	def live
		@phrase = params[:query]
		if !@phrase.nil? and @phrase.length >= 1
	 	   a1 = "%"
	 	   a2 = "%"
	 	   q = a1 + @phrase + a2
	 	   @limit = 15
	 	   	
			@sources = Source.find(:all, :conditions => [ "name LIKE ? OR url LIKE ? OR description LIKE ?", q, q, q], :limit => @limit, :order => 'name ASC')
			
	 	   	@drugs = Drug.find(:all, :conditions => [ "name LIKE ? OR generic_names LIKE ? OR brand_names LIKE ?", q, q, q], :limit => @limit)
			@drugs.sort! do |a, b| b.treatments.count <=> a.treatments.count end

     		@concepts = Concept.all(:conditions => ["name LIKE ? OR description LIKE ?", q, q], :limit => @limit, :order => 'name ASC')
			
			@genes = Gene.all(:conditions => ["hugo_id LIKE ?", q], :order => 'hugo_id ASC', :limit => @limit)
	 	   @total = @sources.length + @drugs.length + @concepts.length + @genes.length
     	
	 	   render(:layout => false)
		else
			render :layout => false, :action => 'nothing'
		end
		
	end
end
