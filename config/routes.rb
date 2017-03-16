Rails.application.routes.draw do
  devise_for :users
  get "/pages/*page" => "pages#show"
  root "pages#home"

  namespace :education do
    root "home#index"
    resources :projects, only: :index
    resources :techniques, only: [:index, :show]
    resources :trainings, only: [:index, :show]
  end

  namespace :company do
    resources :dashboards, only: [:index]
  end
end
