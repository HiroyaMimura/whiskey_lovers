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
  resources:whiskeys do
    resources:whiskey_comments, only: [:create, :destroy]
  end
  get "searches"=>"searches#index"
  resources:users, only: [:show,:edit,:update]
  get "users/unsubscribe"=>"users#unsubscribe"
  patch "users/withdrawal"=>"users#withdrawal"
end

namespace :admin do
  root to:'homes#top'
  resources:whiskeys, only: [:show,:destroy]
  resources:users, only: [:index,:show,:update]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
