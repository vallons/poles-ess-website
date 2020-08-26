Rails.application.routes.draw do
  devise_for :admin

  # Admin ======================================

  namespace :admin do
    resources :themes do
      member do
        delete :destroy_image
      end
    end
    resources :activities
    resources :seos, only: [:index, :edit, :update]
    resource :settings, only: [:create, :show] do
      member do
        delete "destroy_upload/:upload_id", action: :destroy_upload, as: :destroy_upload
      end
    end

    root to: "dashboard#index"
  end

  resources :themes, only: [:show]

  root 'home#index'
end
