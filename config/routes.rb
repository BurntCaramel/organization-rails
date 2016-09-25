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

    resources :texts, except: [:update], param: :sha256
    resources :images, except: [:update], param: :sha256 do
      collection do
        post 'search'
      end    
      member do
        get 'imgix'
      end
    end
    resources :records, except: [:update], param: :sha256

    resources :stories

    resources :s3_credentials
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
