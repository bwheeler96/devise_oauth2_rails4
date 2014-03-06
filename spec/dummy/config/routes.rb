Rails.application.routes.draw do
  devise_for :users

  resources :protected

  mount Devise::Oauth2::Engine => '/oauth'
end
