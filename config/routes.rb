Rails.application.routes.draw do
  resources :jobs
  get 'show' => 'jobs#show_test'
  root 'home#index'
end
