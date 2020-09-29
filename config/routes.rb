Rails.application.routes.draw do
  devise_for :admin

   # Concerns ===================================================================

  concern :upload_destroyable do
    delete "destroy_upload/:upload_id", action: :destroy_upload, as: :destroy_upload, on: :member
  end

  # Admin ======================================

  namespace :admin do
    resources :themes, concerns: :upload_destroyable
    resources :activities, concerns: :upload_destroyable
    resources :seos, only: [:index, :edit, :update]
    resource :settings, only: [:create, :show], concerns: :upload_destroyable
    resources :formations, concerns: :upload_destroyable
    resources :formation_categories
    resources :interfaces, only: [:update]

    root to: "dashboard#index"
  end

  resources :themes, only: [:show]
  resources :activities, only: [:index, :show]
  resources :formations, only: [:index, :show]

  root 'home#index'
end
