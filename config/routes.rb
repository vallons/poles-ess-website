Rails.application.routes.draw do
  devise_for :admin

  # Admin ======================================

  namespace :admin do
    resources :themes do
      member do
        delete :destroy_image
      end
    end
    resources :seos, only: [:index, :edit, :update]

    root to: "dashboard#index"
  end

  resources :themes, only: [:show]

  root 'home#index'
end
