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
    resources :profiles, concerns: [:upload_destroyable, :configurable]
    resources :main_pages, concerns: [:upload_destroyable, :configurable] do
      resources :child_pages, controller: "main_pages/child_pages", concerns: [:upload_destroyable, :configurable]
    end
    resources :activities, concerns: [:upload_destroyable, :configurable]
    resources :formations, concerns: [:upload_destroyable, :configurable]
    resources :formation_categories
    resources :post_categories
    resources :posts, concerns: [:upload_destroyable, :configurable]
    resources :staff_member_categories
    resources :staff_members, concerns: [:upload_destroyable, :configurable]
    resources :adherent_categories
    resources :adherents, concerns: [:upload_destroyable, :configurable]
    resources :partner_categories
    resources :partners, concerns: [:upload_destroyable, :configurable]
    resources :basic_pages, concerns: [:upload_destroyable, :configurable]
    resources :key_numbers
    resources :email_templates, only: [:index, :edit, :update]
    resource :settings, only: [:create, :show], concerns: :upload_destroyable
    resources :seos, only: [:index, :edit, :update]
    resources :events
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
  resources :profiles, only: [:show]
  resources :activities, only: [:index, :show], path: "actions"
  resources :posts, only: [:index, :show], path: "actualites"
  resources :formations, only: [:index, :show, :edit, :update] do
    resources :subscriptions, controller: "formations/subscriptions", only: [:new, :create, :show], path: "inscription"
  end
  resources :main_pages, only: [:show], path: "pages"
  resources :basic_pages, only: [:show], path: "pages-legales"
  resources :resources, only: [:index], path: "ressources"
  resources :staff_members, only: [:index], path: "equipe"
  resources :adherents, only: [:index], path: "adherents"
  resources :partners, only: [:index], path: "partenaires"
  resources :key_numbers, only: [:index], path: "chiffres-cles"
  resources :events, only: [:index], path: "evenements"
  resource :search, only: [:show], path: "recherche"
  resource :newsletters, only: [:create]

  root 'home#index'
end
