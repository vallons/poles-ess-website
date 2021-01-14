# frozen_string_literal: true

module InterfaceHelper
  def interface_max_position(params, model_type)
    return 1 unless active_interface_filter?(params)
    if is_theme_interface?(params)
      return theme_interface_max_position(params[:by_theme], model_type)
    elsif is_profile_interface?(params)
      return profile_interface_max_position(params[:by_profile], model_type)
    end
  end

  def active_interface_filter?(params)
    is_theme_interface?(params) || is_profile_interface?(params)
  end

  def item_position(params, instance)
    if is_theme_interface?(params)
      item_theme_position(instance, params[:by_theme])
    elsif is_profile_interface?(params)
      item_profile_position(instance, params[:by_profile])
    else
      return 1
    end
  end

  def get_interface(instance, params)
    return theme_interface(instance, params[:by_theme]) if is_theme_interface?(params)
    return profile_interface(instance, params[:by_profile]) if is_profile_interface?(params)
    return nil
  end

  protected

  # Theme interface ===================================

  def theme_interface_max_position(theme_id, model_type)
    ThemeInterface.by_theme(theme_id).by_themable_type(model_type).map(&:position).compact.max
  end
  
  def item_theme_position(instance, theme_id)
    theme_interface(instance, theme_id).position
  end

  def is_theme_interface?(params)
    !params[:by_theme].blank? && params[:by_profile].blank?
  end

  def theme_interface(instance, theme_id)
    instance.theme_interfaces.by_theme(theme_id).first
  end

  # Profile interface ===================================

  def profile_interface_max_position(profile_id, model_type)
    ProfileInterface.by_profile(profile_id).by_profilable_type(model_type).map(&:position).compact.max
  end

  def item_profile_position(instance, profile_id)
    profile_interface(instance, profile_id).position
  end

  def is_profile_interface?(params)
    !params[:by_profile].blank? && params[:by_theme].blank?
  end

  def profile_interface(instance, profile_id)
    instance.profile_interfaces.by_profile(profile_id).first
  end
end