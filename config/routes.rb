ActionController::Routing::Routes.draw do |map|
  map.resources :delayed_jobs

  map.resources :sample_types

  map.resources :zygosities

  map.resources :chromosomes

  map.resources :samples


  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'

	
  map.antineoplastic '/drugs/antineoplastics', :controller => 'drugs', :action => 'antineoplastics'
  map.mindmap '/mindmap/:kind/:id', :controller => 'mindmap', :action => :kind
  map.process '/analyses/:id/generate_suggestions', :controller => 'analyses', :action => 'generate_suggestions'
  map.process '/genes/:id/attempt_id_conversions', :controller => 'genes', :action => 'attempt_id_conversions'
  map.process '/genes/attempt_id_conversions', :controller => 'genes', :action => 'attempt_id_conversions'
  map.process '/uploads/:id/link_samples_to_genes', :controller => 'uploads', :action => 'link_samples_to_genes'
  map.process '/uploads/:id/unlink_samples_to_genes', :controller => 'uploads', :action => 'unlink_samples_to_genes'
  
  #map.connect '/concepts/:editgraph', :controller => 'concepts', :action => 'editgraph'
  
  #map.connect 'concepts/:id', :controller => 'concepts', :action => 'editgraph'
  # map.samples '/uploads/:id/samples', :controller => 'uploads', :actions => 'samples'

  map.resources :orientations
  map.resources :aberrations
  map.resources :phenotypes
  map.resources :subconcepts
  map.resources :analyses  
  map.resources :concepts
  map.resources :drugs
  map.resources :formats
  map.resources :genes
  map.resources :imports
  map.resources :members
  map.resource :session
  map.resources :sources
  map.resources :suggestions
  map.resources :treatments
  map.resources :uploads
  map.resources :users
  map.resources :roles
  



  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
