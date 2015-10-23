Rails.application.routes.draw do

  resources :users, except: [:index]

  resources :subs, except: [:destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :posts, except: [:index] do
    resources :comments, only: [:new]

    member do
      post "upvote"
      post "downvote"
    end

  end

  resources :comments, only: [:create, :show, :destroy] do
    member do
      post "upvote"
      post "downvote"
    end
  end
  
end
