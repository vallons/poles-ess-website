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
    resources :formation_categories
    resources :formations, concerns: :upload_destroyable
    resources :post_categories
    resources :posts, concerns: :upload_destroyable
    resources :email_templates, only: [:index, :edit, :update]
    resources :basic_pages
    resources :participants do
      member do
        patch :confirm_participation
        patch :place_in_waiting_line
      end
    end
    resources :interfaces, only: [:update]

    root to: "dashboard#index"
  end

  resources :themes, only: [:show]
  resources :activities, only: [:index, :show]
  resources :posts, only: [:index, :show]
  resources :formations, only: [:index, :show, :edit, :update] do
    resources :subscriptions, controller: "formations/subscriptions", only: [:new, :create, :show]
  end

  root 'home#index'
end
