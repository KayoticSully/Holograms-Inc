ProjectCourse::Application.routes.draw do
  resources :products
  resources :sales
  resources :groups
  resources :keywords
  resources :order_items
  resources :orders
  resources :help_items
  resources :user_types
  resources :users
  resources :sessions
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => redirect('/keywords/featured')
  
  get "home/index"
  get "sessions/new"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as =>"sign_up"
  
  match "orders/add/:id", :to => 'orders#add'
  match "updateShipping/:id/:method/:price" => 'orders#updateShipping'
  match "orders/remove/:id", :to => 'orders#remove'
  match "orders/removeall/:id", :to => 'orders#removeall'
  match "orders/canceOrder/:id", :to => 'orders#cancelOrder'
  match "orders/purchase/:id", :to => 'orders#purchase'
  match "orders/updateqty/:id/:newqty", :to => 'orders#updateqty'
  match "about", :to => 'home#about'
  match "employee", :to => "home#employee"
  match "search",  :to => "keywords#search"
  
  #match "search2",  :to => "keywords#show"
  #match "users/delete/:id", :to => "users#delete_user"
  
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
