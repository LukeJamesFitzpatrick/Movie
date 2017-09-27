Rails.application.routes.draw do

  #get 'relationships/follow_user'

  #get 'relationships/unfollow_user'
  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  resources :comments
  # full /pins resources
  resources :pins do
    member do
      post '/like' => 'pins#like'
    end
  end

  devise_for :users
  resources :users do
    resources :pins, only: [:index]
    member do
      get :following, :followers
    end
  end
  get 'users/:id/' => 'users#show', :as => :user_page

  mount ActionCable.server => '/cable'

  root 'pins#index'
  get "about" => "pages#about"
end
