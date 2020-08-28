# frozen_string_literal: true

module InterfaceHelper

  def interface_max_position(params, model_type)
    return 1 unless active_interface_filter?(params)
    if is_theme_interface?(params)
      theme_interface_max_position(model_type)
    end
  end

  def active_interface_filter?(params)
    is_theme_interface?(params)
  end

  def item_position(params, instance)
    if is_theme_interface?(params)
      item_theme_position(instance, params[:by_theme])
    else
      return 1
    end
  end

  def get_interface(instance, params)
    return theme_interface(instance, params[:by_theme]) if is_theme_interface?(params)
    return nil
  end

  protected

  # Theme interface ===================================

  def theme_interface_max_position(model_type)
    ThemeInterface.by_themable_type(model_type).map(&:position).compact.max
  end
  
  def item_theme_position(instance, theme_id)
    theme_interface(theme_id, instance).position
  end

  def is_theme_interface?(params)
    params[:by_theme].present?
  end

  def theme_interface(instance, theme_id)
    instance.theme_interfaces.by_theme(theme_id).first
  end


end