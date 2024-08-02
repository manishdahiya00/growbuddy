Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "main#index"

  get "google_login" => "main#google_login"
  get "verification/:id" => "main#verification"
  post "verification/:id" => "main#verification"
  delete "logout" => "main#logout"

  get "app_offer/:app_offer" => "main#app_offer", as: "app_offer"
  post "app_offer/:app_offer" => "main#app_offer"

  get "refer" => "main#refer"
  post "refer" => "main#refer"

  get "referral" => "main#referral"
  post "referral" => "main#referral"

  get "profile" => "main#profile"

  get "/admin/dashboard" => "admin/dashboard#index"
  get "/admin" => "admin/login#new"
  post "/admin" => "admin/login#login"
  delete "/admin/logout" => "admin/login#logout"

  get "postback" => "main#postback"

  namespace :admin do
    resources :articles
    resources :app_banners
    resources :users
    resources :app_offers do
      resources :offer_events
    end
    resources :affiliates
    resources :referrers
    resources :postbacks
  end
end
