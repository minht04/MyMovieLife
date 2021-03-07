Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :members, controllers: {
    sessions:      'members/sessions',
    passwords:     'members/passwords',
    registrations: 'members/registrations'
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'members/sessions#new_guest'
  end

  scope module: :member do
    root to: 'homes#top'
    get 'home/about' => 'homes#about'
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :members, only: [:show, :edit, :index, :update] do
      resource :relationships, only: [:create, :destroy]
      member do
        get 'follows'  #follower一覧
        get 'followers'  # followed一覧
      end
    end
  end

  namespace :admin do
  end
  
end
