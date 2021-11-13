Rails.application.routes.draw do
  root :to => 'restaurants#index'

  scope :protocol => 'https://', :constraints => { :protocol => 'https://' } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: { registrations: "registrations", sessions: "sessions" }
  end

  resources :restaurants, only: %i[show create update destroy] do
    resources :dietaries, only: %i[index]
    resources :menus, only: %i[index]
    resources :users, only: %i[index]
  end

  resources :dietaries, only: %i[show create update destroy]

  resources :users, only: %i[update]

  get :find_current_user, controller: "users"

  resources :menus, only: %i[show create update destroy] do
    resources :menu_categories, only: %i[index]
  end

  resources :menu_categories, only: %i[show create update destroy] do
    resources :menu_items, only: %i[index]
  end

  resources :menu_items, only: %i[show create update destroy] do
    resources :item_sizes, only: %i[index show create update destroy]
    resources :dietary_instances, only: %i[index create destroy]
  end
end
