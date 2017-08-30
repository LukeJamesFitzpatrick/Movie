Rails.application.routes.draw do

  # full /pins resources
  resources :pins do

    member do
      post '/like' => 'pins#like'
    end
  end

  devise_for :users
  root 'pins#index'
  get "about" => "pages#about"
end