Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

devise_scope :user do
  post 'users/guest_sign_in'=>'public/sessions#guest_sign_in'
end

scope module: :public do
	root to:"homes#top"
	get "services"=>"homes#services"
	get "privacies"=>"homes#privacies"
  resources:whiskeys do
    resources:whiskey_comments, only: [:create, :destroy]
    resource:favorites, only: [:create, :destroy]
  end
  get "searches_name"=>"searches#searches_name"
  get "searches_tag"=>"searches#searches_tag"
  get "searches_price"=>"searches#searches_price"
  get "users/unsubscribe"=>"users#unsubscribe", as: "unsubscribe"
  patch "users/withdrawal"=>"users#withdrawal", as: "withdrawal"
  get "users/user_favorites"=>"users#user_favorites"
  resources:users, only: [:show,:edit,:update]
  resources :notifications, only: [:index, :destroy]
  resource :contacts, only: [:new, :create] do
    get "/thanks" => "contacts#thanks"
  end
end

namespace :admin do
  root to:'homes#top'
  resources:whiskeys, only: [:show,:destroy]
  resources:users, only: [:index,:show,:edit,:update]
  resources:whiskey_comments, only: [:destroy]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
