Rails.application.routes.draw do



  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks
    root 'home#index'
    mount ActionCable.server, at: '/cable'

    resources :rooms
    resources :room_messages
    resources :quotes
    get "accept_quote" => 'quotes#accept_quote'
    get "decline_quote" => 'quotes#decline_quote'
    resources :quote_elements
    resources :jobs, param: :slug
    get 'show' => 'jobs#show_test'
    get 'show_quote' => 'quotes#show_test'

    resources :reviews
    resources :subcategories
    resources :categories do
      member do
        get :get_subcategories, defaults: { format: "js" }
      end
    end
    resources :companies
    namespace :admin do
      get "index" => "home#index"
      resources :jobs, param: :slug
      resources :categories
      resources :subcategories
      resources :reviews
      resources :quotes
      resources :format_deliveries
      resources :users
      resources :professions
    end
  end

end
