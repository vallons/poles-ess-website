class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :get_menu_items
  after_action :flash_to_headers, if: -> { request.xhr? && flash.present? }

  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_to root_path if !request.xhr?
  end

  private

  def get_menu_items
    @themes = Theme.all
  end

  def flash_to_headers
    [:error, :alert, :warning, :notice].each do |type|
      if flash[type].present?
        content = { message: flash[type], type: ApplicationHelper::FLASH_BS_TYPES[type] }
        response.headers['X-Message'] = content.to_json
        flash.discard
        break
      end
    end
  end


end
