Rails.application.routes.draw do

  root :to => 'catalog#index'

  get 'about' => 'about#index'
  get 'checkout' => 'checkout#index'
  get 'admin/author' => 'admin/author#index'
  get 'admin/publisher' => 'admin/publisher#index'
  get 'admin/book' => 'admin/book#index'
  get 'admin/order' => 'admin/order#index'

  get 'admin/author/new'
  post 'admin/author/create'
  get 'admin/author/edit'
  post 'admin/author/update'
  post 'admin/author/destroy'
  get 'admin/author/show'
  get 'admin/author/show/:id' => 'admin/author#show'
  get 'admin/author/index'

  get 'admin/publisher/new'
  post 'admin/publisher/create'
  get 'admin/publisher/edit'
  post 'admin/publisher/update'
  post 'admin/publisher/destroy'
  get 'admin/publisher/show'
  get 'admin/publisher/show/:id' => 'admin/publisher#show'
  get 'admin/publisher/index'

  get 'admin/book/new'
  post 'admin/book/create'
  get 'admin/book/edit'
  post 'admin/book/update'
  post 'admin/book/destroy'
  get 'admin/book/show'
  get 'admin/book/show/:id' => 'admin/book#show'
  get 'admin/book/index'

  post 'admin/order/close'
  post 'admin/order/destroy'
  get 'admin/order/show'
  get 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'

  get 'catalog/show'
  get 'catalog/show/:id' => 'catalog#show'
  get 'catalog/index'
  get 'catalog/latest'

  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'

  get 'user_sessions/new'
  get 'user_sessions/create' # for showing failed login screen after restarting web server
  post 'user_sessions/create'
  get 'user_sessions/destroy'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  get 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'

  get 'password_reset/new'
  post 'password_reset/create'
  get 'password_reset/edit'
  post 'password_reset/update'

  get 'checkout/index'
  post 'checkout/submit_order'
  get 'checkout/thank_you'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
