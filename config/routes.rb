Rails.application.routes.draw do
  root to: 'dashboard#index'

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  resources :organizations do
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :tag_item_relationships, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
