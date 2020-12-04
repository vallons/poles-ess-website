Rails.application.routes.draw do
  devise_for :admin

  # Concerns ===================================================================

  concern :upload_destroyable do
    delete "destroy_upload/:upload_id", action: :destroy_upload, as: :destroy_upload, on: :member
  end

  concern :configurable do
    member do
      get   :edit_configuration
      patch :update_configuration
    end
  end

  # Admin ======================================

  namespace :admin do
    resources :themes, concerns: [:upload_destroyable, :configurable]
    resources :main_pages, concerns: [:upload_destroyable, :configurable]
    resources :activities, concerns: [:upload_destroyable, :configurable]
    resources :formations, concerns: [:upload_destroyable, :configurable]
    resources :formation_categories
    resources :post_categories
    resources :posts, concerns: [:upload_destroyable, :configurable]
    resources :basic_pages, concerns: [:upload_destroyable, :configurable]
    resources :key_numbers
    resources :email_templates, only: [:index, :edit, :update]
    resource :settings, only: [:create, :show], concerns: :upload_destroyable
    resources :seos, only: [:index, :edit, :update]
    resources :participants do
      member do
        patch :confirm_participation
        patch :place_in_waiting_line
      end
    end
    resources :interfaces, only: [:update]

    root to: "dashboard#index"
  end

  # Public ============================================

  resources :themes, only: [:show]
  resources :activities, only: [:index, :show]
  resources :posts, only: [:index, :show]
  resources :formations, only: [:index, :show, :edit, :update] do
    resources :subscriptions, controller: "formations/subscriptions", only: [:new, :create, :show]
  end
  resources :main_pages, only: [:show]
  resources :basic_pages, only: [:show]
  resources :resources, only: [:index]
  resource :search, only: [:show]

  root 'home#index'
end
