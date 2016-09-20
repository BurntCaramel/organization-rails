Rails.application.routes.draw do
  root to: 'dashboard#index'

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  if Rails.env.development?
    get '/auth/force' => 'auth0#dev_force_sign_in'
  end

  resources :organizations do
    resources :tags
    resources :item_tag_relationships, only: [:create, :destroy]

    resources :texts
    resources :images
    resources :stories

    resources :s3_credentials
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
