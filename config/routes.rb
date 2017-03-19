Rails.application.routes.draw do
  devise_for :users, only: :session
  get "/pages/*page" => "pages#show"
  root "pages#home"

  namespace :education do
    root "home#index"
    resources :projects
    resources :trainings
    resources :techniques, only: [:index, :show]
    resources :feedbacks, only: [:new, :create]
  end

  namespace :employer do
    resources :dashboards, only: [:index]
  end

  namespace :admin do
    resources :dashboards, only: [:index]
    root "dashboards#index"
  end
end
