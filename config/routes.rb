WorkshopCafe::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  resources :recommendations
  resources :songs do
    member do
      put :vote_up, :vote_down
    end
  end
end
