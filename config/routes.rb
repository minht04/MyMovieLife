Rails.application.routes.draw do
  namespace :member do
    get 'members/show'
  end
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

  scope module: :member do
    root to: 'homes#top'
    get 'home/about' => 'homes#about'
    resources :posts
    resources :members, only: [:show, :edit, :index, :update]
  end

  namespace :admin do
  end
end
