Rails.application.routes.draw do
  resources :users
  resource :session, only: [:create, :destroy, :new]
  resources :subs, except: [:destroy]
  resources :posts, except: [:index]
end
