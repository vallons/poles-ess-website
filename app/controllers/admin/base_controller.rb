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

  def resources_attributes
    [
      :id,
      :title,
      :category,
      :link,
      :document,
      :position,
      :_destroy
    ]
  end

  def menu_blocks_attributes
    [
      :id,
      :title,
      menu_items_attributes: [
        :id,
        :title,
        :url,
        :position,
        :_destroy
      ]
    ]
  end

  def seo_attributes
    [
      :id,
      :slug,
      :title,
      :description
    ]
  end

  def redirect_after_update_main_page(page)
    if page.no_parent?
      redirect_to params[:continue].present? ? edit_admin_main_page_path(page) : admin_main_pages_path
    else
      redirect_to params[:continue].present? ? edit_admin_main_page_child_page_path(page.parent_page, page) : admin_main_page_child_pages_path(page.parent_page)
    end
  end
end
