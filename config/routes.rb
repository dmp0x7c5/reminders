Rails.application.routes.draw do
  resources :projects do
    post :sync, on: :collection
    post :toggle_state, on: :member
    post :archive, on: :member
    get "history" => "project_history#index", on: :member
  end

  resources :project_checks do
    post :toggle_state
    post :override_deadline
    get :pick_person
    post :reassign_person
    post :assign_checker
    get "history" => "checks_history#index", on: :member
  end

  post "check_assignments/complete_check" => "check_assignments#complete_check", :as => :complete_check

  resources :reminders do
    post :sync_projects
  end

  resources :skills, only: [:index] do
    post :toggle, on: :collection
  end

  resources :users, only: [:index] do
    post :archive, on: :member
    post :toggle_admin, on: :member
    post :toggle_paused, on: :member
    post :toggle_paused_by_user, on: :member
  end

  root to: "visitors#index"

  namespace :admin do
    resources :users do
      resources :skills, only: [:index] do
        post :toggle, on: :collection
      end
    end

    resources :project_checks, only: [] do
      resources :check_assignments, only: [:create, :destroy]
    end
  end

  get "/auth/:provider/callback" => "sessions#create"
  get "/signin" => "sessions#new", :as => :signin
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"
end
