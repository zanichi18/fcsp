Rails.application.routes.draw do
  devise_for :users
  get "/pages/*page" => "pages#show"
  root "pages#home"

  namespace :education do
    root "home#index"
  end
end
