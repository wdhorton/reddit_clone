Rails.application.routes.draw do

  resources :users, except: [:index]

  resources :subs, except: [:destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :posts, except: [:index]

end
