module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    before_action :set_base_breadcrumbs, :set_specific_breadcrumbs

    def set_base_breadcrumbs
      @breadcrumbs = []
      @breadcrumbs << [ "Accueil", root_path ]
    end

    def set_specific_breadcrumbs
      # A surcharger dans chaque controller
    end
  end
end