# frozen_string_literal: true

module SlugsAndRedirections
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      respond_to do |format|
        format.js { head :not_found }
        format.json { head :not_found }
        format.html do
          flash[:error] = "Élement non trouvé"
          redirect_to root_path
        end
      end
    end
  end

  def get_object_from_param_or_redirect(collection, action = "show")
    object = collection.from_param params[:id]

    if object.to_param != params[:id]
      redirect_to(action: action, id: object.to_param, status: :moved_permanently)
      return
    end

    @seo_title = object.seo_title if object.seo_title.present?
    @seo_description = object.seo_description if object.seo_description.present?

    object
  end
end
