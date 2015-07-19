Rails.application.routes.draw do
  resources :projects, only: [:index] do
    post :sync, on: :collection
    post :toggle_state, on: :member
    get "history" => "project_history#index", on: :member
  end

  resources :project_checks do
    post :toggle_state
    get "history" => "checks_history#index", on: :member
  end

  post "check_assignments/assign_checker" => "check_assignments#assign_checker", :as => :assign_checker
  post "check_assignments/complete_check" => "check_assignments#complete_check", :as => :complete_check

  resources :reminders do
    post :sync_projects
  end

  root to: "visitors#index"

  get "/auth/:provider/callback" => "sessions#create"
  get "/signin" => "sessions#new", :as => :signin
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"
end
