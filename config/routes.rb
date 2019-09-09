Rails.application.routes.draw do
  resources :quotes
  resources :jobs
  get 'show' => 'jobs#show_test'
  root 'home#index'
end
