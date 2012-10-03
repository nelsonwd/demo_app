DemoApp::Application.routes.draw do
  resources :leaders

  resources :auto24h_fold_changes

  resources :auto1h_fold_changes

  resources :hetero24h_fold_changes

  resources :hetero1h_fold_changes

  resources :treatments

  resources :fold_changes

  resources :de_analyses

  resources :experiments

  resources :gene_ontologies

  resources :interpros

  resources :annotation_sources

  resources :annotations

  resources :features

  resources :sequences

  get "sessions/new"


  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  match '/signup', :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/password', :to => 'users#password'
  match '/submit', :to => 'blast#submit'
  match '/about', :to => 'pages#about'
  match '/wait', :to => 'blast#wait'

  match '/result', :to => 'blast#result'

  get "pages/blast"

  get "pages/about"

  get "blast_dbs/fastasearch"  
  match '/fastasearch', :to => 'blast_dbs#fastasearch'

  get "blast_dbs/sequence_map"
  match '/sequence_map', :to => 'blast_dbs#sequence_map'

  get "blast_dbs/aa_sequence_map"
  match '/aa_sequence_map', :to => 'blast_dbs#aa_sequence_map'

  get "de_data/heatmap"
  match '/heatmap', :to => 'de_data#heatmap'  

  get "de_data/cluster_annot"
  match '/cluster_annot', :to => 'de_data#cluster_annot'

  get "leaders/detail"
  match '/leader_detail', :to => 'leaders#detail'



  get "users/password"
  get "users/new"
  resources :microposts

  resources :de_data
  resources :blast_dbs

  root :to => 'pages#blast'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
