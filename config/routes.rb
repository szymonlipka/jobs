Rails.application.routes.draw do
  root to: 'pages#home'
  get :sort_jobs, controller: 'pages'
  resources :jobs, only: :create
end
