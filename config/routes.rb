WorkshopCafe::Application.routes.draw do
  devise_for :users

  root :to => 'home#index'

  namespace :admin do
    resource :dashboard, :controller => :dashboard
  end

  resources :recommendations
  resources :songs do
    member do
      put :vote_up, :vote_down, :play_now
    end

    collection do
      get :upcoming
    end
  end
end
