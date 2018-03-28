Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # namespace the controllers without affecting the URI

  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :todos, only: :index
  end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :todos do
      resources :items
    end
  end
  
  # resources :users, only: [:create]
  # root to: 'authentication#authenticate'
  # root controller: 'authentication', action: 'authenticate'
  root "static#show"
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'auth/logout', to: 'authentication#logout'

end
