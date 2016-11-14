Rails.application.routes.draw do
  get 'ripples/create'

  get 'ripples/destroy'

  root to: 'dashboard#index'

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'

  if Rails.env.development?
    get '/auth/force' => 'auth0#dev_force_sign_in'
  end

  resources :organizations do
    resources :channels do
      resources :ripples, only: [:create, :destroy] do
        collection do
          resources :keys, only: [:show], param: :key_base64, controller: :ripples, action: :index
        end
      end
    end

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

    resources :service_credentials, id: /[A-Za-z0-9\.]+?/, format: /json/
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
