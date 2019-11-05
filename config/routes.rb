Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {:registrations => 'registrations',omniauth_callbacks: 'users/omniauth_callbacks'}
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks,controllers: {:registrations => 'registrations'}
    root 'home#index'
    mount ActionCable.server, at: '/cable'
    resources :autocompletes
    resources :addresses
    resources :rooms
    resources :room_messages
    resources :quotes do
      member do
        post :pay
        get :accept
        get :decline
      end
    end
    resources :subscriptions
    resources :users, only: [:show] do
      collection do
        get :my_subscription
        get :get_tags, defaults: { format: "js" }
      end
    end
    resources :quote_elements
    resources :jobs, param: :slug
    get 'show' => 'jobs#show_test'
    get 'show_quote' => 'quotes#show_test'
    get 'search_result' => 'home#search_result'
    post  'search_result' => 'home#search_result'
    resources :reviews
    resources :subcategories
    resources :categories do
      member do
        get :get_subcategories, defaults: { format: "js" }
      end
    end
    get "buy_credits" => 'home#buy_credits'
    get "checkout_credit" => 'home#checkout_credit'
    post "add_credits" => 'home#add_credits'
    resources :companies
    resources :portfolios
    get "delete_image_attachment" => "portfolios#delete_image_attachment"
    namespace :admin do
      get "index" => "home#index"
      resources :jobs, param: :slug
      resources :categories
      resources :subcategories
      resources :reviews
      resources :plan_limitations
      resources :credits_offers
      resources :quotes
      resources :format_deliveries
      resources :users
      resources :professions
    end
  end

end
