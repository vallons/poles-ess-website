class KeyNumbersController < ApplicationController

  # before_action :set_breadcrumbs

  def index
    @key_numbers = KeyNumber.enabled.order(:position)
  end

  private # =====================================================

  # def set_breadcrumbs
  #   @breadcrumbs = []
  #   @breadcrumbs << [ "Accueil",    root_path ]
  #   @breadcrumbs << [ "L'ESS'",    main_page_path(MainPage.find_by(title: "L'ESS")) ]
  #   @breadcrumbs << [ "Chiffre-clés",  adherents_path ]
  # end
end
