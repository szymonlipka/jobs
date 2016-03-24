Rails.application.routes.draw do
  root to: 'pages#home'
  get :sort_jobs, controller: 'pages'
end
