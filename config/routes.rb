Rails.application.routes.draw do
  devise_for :companies
  root to: 'pages#home'
  resources :employees
  get 'dashboard', to: 'employees#dashboard', as: :dashboard
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
