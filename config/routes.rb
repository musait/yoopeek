Rails.application.routes.draw do
  root 'home#index'

  resources :quotes
  resources :jobs
  get 'show' => 'jobs#show_test'
  get 'show_quote' => 'quotes#show_test'

  namespace :admin do
    get "index" => "home#index"
  end
end
