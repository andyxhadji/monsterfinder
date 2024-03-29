Rails.application.routes.draw do
  api_version(:module => "V4", :parameter => {:name => "version", :value => "4"}) do
    get '' => 'monsters#index'
    resources :monsters
    resources :users
    get 'search/:monster' => 'monsters#search'
    match 'vote', to: 'users#vote', via: [:post]
    match 'hide', to: 'monsters#hide', via: [:post]
    match 'remove_notifications', to: 'users#remove_notifications', via: [:post]
    match 'update_channel_id', to: 'users#update_channel_id', via: [:post]
    match 'replace_notification', to: 'users#replace_notification', via: [:post]
    match 'get_chatroom', to: 'chatrooms#get_chatroom', via: [:get]
  end
  api_version(:module => "V3", :parameter => {:name => "version", :value => "3"}) do
    get '' => 'monsters#index'
    resources :monsters
    resources :users
    get 'search/:monster' => 'monsters#search'
    match 'vote', to: 'users#vote', via: [:post]
    match 'hide', to: 'monsters#hide', via: [:post]
    match 'remove_notifications', to: 'users#remove_notifications', via: [:post]
    match 'update_channel_id', to: 'users#update_channel_id', via: [:post]
    match 'replace_notification', to: 'users#replace_notification', via: [:post]
    match 'get_chatroom', to: 'chatrooms#get_chatroom', via: [:get]
  end
  api_version(:module => "V2", :parameter => {:name => "version", :value => "2"}) do
    get '' => 'monsters#index'
    resources :monsters
    resources :users
    get 'search/:monster' => 'monsters#search'
    match 'vote', to: 'users#vote', via: [:post]
    match 'hide', to: 'monsters#hide', via: [:post]
    match 'remove_notifications', to: 'users#remove_notifications', via: [:post]
    match 'update_channel_id', to: 'users#update_channel_id', via: [:post]
    match 'replace_notification', to: 'users#replace_notification', via: [:post]
  end
  api_version(:module => "V1", :parameter => {:name => "version", :value => "1"}, :default => true) do
    get '' => 'monsters#index'
    resources :monsters
    resources :users
    get 'search/:monster' => 'monsters#search'
    match 'vote', to: 'users#vote', via: [:post]
  end

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
