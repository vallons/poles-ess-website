class KeyNumbersController < ApplicationController

  before_action :set_breadcrumbs

  def index
    @key_numbers = KeyNumber.enabled.order(:position)
  end

  private # =====================================================

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs << [ "Accueil",    root_path ]
    @breadcrumbs << [ "Chiffre-clés",  key_numbers_path ]
  end
end
