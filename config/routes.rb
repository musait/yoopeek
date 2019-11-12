Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: {:registrations => 'registrations',omniauth_callbacks: 'users/omniauth_callbacks'}
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks,controllers: {:registrations => 'registrations'}
    root 'home#index'
    devise_scope :user do
      match '/users' => "registrations#new", via: :get
    end
    mount ActionCable.server, at: '/cable'
    resources :autocompletes
    resources :addresses
    resources :rooms
    resources :room_messages
    get "worker_jobs" => "jobs#worker_jobs"
    resources :quotes do
      member do
        post :pay
        get :accept
        get :decline
      end
    end
    resources :subscriptions do
      collection do
        get :invoices
      end
      member do
        get :invoice
      end
    end
    resources :users, only: [:show] do
      collection do
        get :my_subscription
        get :get_tags, defaults: { format: "js" }
      end
    end
    resources :quote_elements
    resources :jobs, param: :slug do
      member do
        get :finished
        get :invoice
      end
    end
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
    get "credits_payments_invoices" => 'home#credits_payments_invoices'
    get "invoice_credits_payment" => 'home#invoice_credits_payment'
    get "checkout_credit" => 'home#checkout_credit'
    post "add_credits" => 'home#add_credits'
    post "stripe_subscription_webhook" => 'home#stripe_subscription_webhook'
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
      resources :forbiden_words
    end
  end

end
