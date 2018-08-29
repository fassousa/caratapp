Rails.application.routes.draw do
  get 'orders/new'
  get 'orders/create'
  devise_for :users
  resources :employees
  get 'dashboard', to: 'employees#dashboard', as: :dashboard
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'rewards', to: 'pages#rewards', as: :rewards

  get 'rewards', to: 'pages#rewards'

  authenticated :user do
    root 'employees#dashboard', as: :authenticated_root
  end
  root to: 'pages#home'
  post 'employees/parse', to: 'employees#parse'
end
