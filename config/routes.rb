Rails.application.routes.draw do
  devise_for :admins

  # Admin ======================================
  namespace :admin do
    # resources :images, only: :create

    # namespace :actu do
    #   resources :categories, except: [:show]
    #   resources :posts, except: [:show] do
    #     get :picture_form, on: :collection
    #     patch :sort_picture, on: :member
    #   end
    #   root to: "posts#index"
    # end
    # resources :basic_pages, only: [:edit, :update]
    # resources :seos, only: [:index, :edit, :update]

    root to: "dashboard#index"
  end

  root 'home#index'
end
