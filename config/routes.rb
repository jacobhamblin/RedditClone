Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :destroy, :new]
  resources :subs, except: [:destroy] do
    resources :posts, except: [:index]
  end
end
