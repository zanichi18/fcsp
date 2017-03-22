Rails.application.routes.draw do
  devise_for :users, only: :session
  get "/pages/*page" => "pages#show"
  root "pages#home"
  resources :companies, only: :show

  namespace :education do
    root "home#index"
    resources :projects do
      resources :comments
    end
    resources :trainings
    resources :techniques, only: [:index, :show]
    resources :feedbacks, only: [:new, :create]
    resources :courses, only: [:index, :show]
    resources :trainings, only: :index
    resources :posts, only: [:index, :create, :show]
  end

  namespace :employer do
    resources :dashboards, only: :index
    root "dashboards#index"
    resources :companies do
      resources :jobs, only: [:new, :create]
    end
  end

  namespace :admin do
    resources :dashboards, only: :index
    root "dashboards#index"
    resources :companies, only: [:new, :create, :show]
    resources :users, only: [:new, :create]
  end
end
