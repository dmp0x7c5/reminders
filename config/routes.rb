Rails.application.routes.draw do
  resources :projects, only: [:index] do
    post :sync, on: :collection
  end

  resources :project_checks do
    post :toggle_state
  end

  resources :reminders do
    post :sync_projects
  end

  root to: "visitors#index"

  get "/auth/:provider/callback" => "sessions#create"
  get "/signin" => "sessions#new", :as => :signin
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"
end
