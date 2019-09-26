Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
    root 'home#index'

    resources :quotes
    resources :jobs
    get 'show' => 'jobs#show_test'
    get 'show_quote' => 'quotes#show_test'

    namespace :admin do
      get "index" => "home#index"
    end
  end

end
