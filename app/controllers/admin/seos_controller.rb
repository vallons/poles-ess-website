# frozen_string_literal: true

class Admin::SeosController < Admin::BaseController
  before_action :set_seo, only: [:edit, :update]

  def index
    @seos = Seo.with_param.order(:param)
  end

  def edit
  end

  def update
    if @seo.update(seo_params)
      flash[:notice] = "Les SEO ont été mis à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_seo_path(@seo) : admin_seos_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour des SEO"
      render :edit
    end
  end

  private

  def set_seo
    @seo = Seo.with_param.find(params[:id])
  end

  def seo_params
    params
      .require(:seo)
      .permit(
        :title,
        :description
      )
  end
end
