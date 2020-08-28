class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :set_default_seos!, :get_menu_items
  after_action :flash_to_headers, if: -> { request.xhr? && flash.present? }

  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_to root_path if !request.xhr?
  end

  protected

  def seo_title
    [@seo_title, Setting.project_name].join(' - ')
  end
  helper_method :seo_title

  def seo_description
    [@seo_description, Setting.project_name].join(' - ')
  end
  helper_method :seo_description

  def get_seo_for_static_page(param)
    seo = Seo.where(param: param).first
    return if seo.blank?

    @seo_title = seo.title if seo.title.present?
    @seo_description = seo.description if seo.description.present?
  end


  private

  def get_menu_items
    @themes = Theme.order(:position)
  end

  def set_default_seos!
    @seo_title       ||= Setting.project_name
    @seo_description ||= Setting.project_name
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
