Rails.application.routes.draw do

  # full /pins resources
  resources :pins do


    member do
      post '/like' => 'pins#like'
    end
  end

  devise_for :users
  resources :users do
    resources :pins, only: [:index]
  end
  get 'users/:id/' => 'users#show', :as => :user_page

  root 'pins#index'
  get "about" => "pages#about"
end
