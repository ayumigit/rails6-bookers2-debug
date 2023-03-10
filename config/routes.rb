Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  get "search" => "searches#search"
  get "search/result" => "searches#result"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  devise_for :users
  get "home/about"=>"homes#about", as: "about"

  resources :books, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end


  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
      get :followings, :followers
    end
  end

  resources :groups, except: [:destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end