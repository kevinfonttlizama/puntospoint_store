Rails.application.routes.draw do
  # Ruta raíz dirigida al dashboard del administrador
  root to: 'admins#dashboard'

  # Rutas para Sesiones (Autenticación)
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Rutas CRUD para Productos, Categorías, Clientes y Compras
  resources :products
  resources :categories
  resources :customers
  resources :purchases

  # Rutas para las APIs
  namespace :api do
    namespace :v1 do

      get 'apidocs', to: 'apidocs#index'
      post 'authenticate', to: 'authentication#authenticate'

      get 'products/most_purchased', to: 'products#most_purchased'
      get 'products/top_earning', to: 'products#top_earning'

    

      resources :purchases, only: [:index] do
        collection do
          get 'by_granularity'
        end
      end
    end
  end
  

  get '/swagger' => redirect('/swagger-ui/index.html?url=/api/v1/api-docs.json')

end
