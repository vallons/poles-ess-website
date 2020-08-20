Rails.application.routes.draw do
  devise_for :admin

  # Admin ======================================

  namespace :admin do
    resources :themes do
      member do
        delete :destroy_image
      end
    end
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
