BgiApp::Application.routes.draw do
  devise_for :users, :controllers => {:registrations =>  'registrations', :omniauth_callbacks => "users/omniauth_callbacks"}, :path => 'auth', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  devise_scope :user do
     post '/auth/mobile_signin', :to => 'registrations#mobile_signin'
  end
  root 'pages#home'
  get 'home', :to => 'pages#home'
  get '/contact', :to => 'pages#contact'
  get '/about', :to => 'pages#about'
  get '/help', :to => 'pages#help'

  get '/country/:iso', :to => 'countries#fetch',  :defaults => {:format=>'json'}
  get '/fetch_countries', :to => 'countries#fetch_all', :defaults => {:format => 'json'}

  get '/fetch_states/:cid', :to => 'states#fetch_by_cid', :defaults => {:format => 'json'}

  #Call Log

  post '/log/submit', :to => 'calllogs#submit'

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
