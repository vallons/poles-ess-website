# frozen_string_literal: true

class Admin::EmailTemplatesController < Admin::BaseController
  before_action :get_template, only: [:edit, :update, :destroy, :sort_picture]

  def index
    @templates = EmailTemplate.all
  end

  def edit
  end

  def update
    if @template.update(template_params)
      flash[:notice] = "L'actualité a été mise à jour avec succès"
      redirect_to params[:continue].present? ? edit_admin_email_template_path(@template) : admin_email_templates_path
    else
      flash[:error] = "Une erreur s'est produite lors de la mise à jour de l'actualité"
      render :edit
    end
  end

  private

  def get_template
    @template = EmailTemplate.find params[:id]
  end

  def template_params
    params
      .require(:template)
      .permit(
        :body
      )
  end
end
