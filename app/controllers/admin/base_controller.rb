# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'administration'

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.js { head :not_found }
      format.json { head :not_found }
      format.html do
        flash[:error] = "Élement non trouvé"
        redirect_to admin_root_path
      end
    end
  end

  protected

  def seo_attributes
    [
      :id,
      :slug,
      :title,
      :description
    ]
  end

  private

end
