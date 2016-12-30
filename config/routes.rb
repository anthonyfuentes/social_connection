
Rails.application.routes.draw do
  root 'users#new'

  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  resources :friendings, only: :create
  get 'part-ways', to: 'friendings#destroy'

  resource :comments, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]

  resources :users, except: [:show] do
    get 'friends', to: 'friendings#index'

    resources :photos, except: [:edit, :update]
    resources :posts, only: [:create, :destroy]

    resource :profile, only: [:update]
    get 'profile', to: 'profiles#show'
    get 'profile/edit', to: 'profiles#edit'

    get 'newsfeed', to: 'newsfeeds#show'
    get 'timeline', to: 'timelines#show'
  end
end
