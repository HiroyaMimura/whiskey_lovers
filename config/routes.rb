Rails.application.routes.draw do

  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'whiskeys/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/unsubscribe'
  end
  namespace :public do
    get 'searches/index'
  end
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

scope module: :public do
	root to:"homes#top"
  resources:whiskeys
  get "searches"=>"searches#index"
  resources:users, only: [:show,:edit,:update]
  get "customers/unsubscribe"=>"customers#unsubscribe"
  patch "customers/withdrawal"=>"customers#withdrawal"
end

namespace :admin do
  root to:'homes#top'
  resources:whiskeys, only: [:show,:destroy]
  resources:users, only: [:index,:show,:update]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
