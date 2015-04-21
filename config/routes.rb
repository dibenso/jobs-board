Rails.application.routes.draw do
  get 'companies/index'

  get 'companies/show'

  get 'users/index'

  get 'employers/index'

  devise_for :employers, controllers: {
    registrations: 'employers/registrations'
  }
  devise_for :admins
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :jobs

  resources :job_applications, only: [:index, :show, :destroy]
  
  post 'job_applications/:job_id/create' => 'job_applications#create'
  get 'job_applications/:job_id/new' => 'job_applications#new'

  resources :employers, only: [:index]

  post 'employers/join_company' => 'employers#join_company'
  post 'employers/add_company' => 'employers#add_company'

  resources :users, only: [:index]

  root to: 'jobs#index'

  get 'companies' => 'companies#index'
  get 'companies/:id/jobs', to: 'companies#jobs', as: 'company_jobs'
  resources :companies, only: [:show] do
    resources :reviews, only: [:create]
  end
  resources :reviews, only: [:edit, :update, :destroy]
  get 'reviews' => 'reviews#index'
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
