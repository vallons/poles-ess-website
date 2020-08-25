# frozen_string_literal: true

class Admin::SettingsController < Admin::BaseController

  def create
    setting_params.keys.each do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end
    if setting_upload_params.present? && !(Setting.logo_instance.update_attributes(setting_upload_params))
      update_logo
    else
      flash[:notice] = "Les paramètres ont bien été mis à jour"
    end
    redirect_to action: :show
  end

  def destroy_upload
    attachment = ActiveStorage::Attachment.find(params[:upload_id])
    attachment.purge
    flash[:notice] = "L'image a bien été supprimée"
    redirect_action = params[:redirect] || :index
    redirect_to action: redirect_action
  end

  private
  
  def setting_params
    params.require(:setting).permit(:project_name)
  end

  def setting_upload_params
    params.require(:setting).permit(:logo)
  end

  def update_logo
    logo_instance = Setting.logo_instance
    if logo_instance.update_attributes(setting_upload_params)
      flash[:notice] = "Les paramètres ont bien été mis à jour"
    else
      flash[:error] = logo_instance.errors.full_messages.first
    end
  end
end
