module ApplicationHelper

  def model_is_defined(model_name)
    model_file_path = Rails.root.join("app/models/#{model_name.underscore}.rb")

    File.exist?(model_file_path)
  end

  # NOTIFICATIONS FLASH ##########################################################

  FLASH_BS_TYPES = {
    error: "danger",
    alert: "warning",
    warning: "warning",
    notice: "success"
  }.freeze

  # Affichage des notifications flash s'il y en a.
  #
  def flash_messages
    result = content_tag :div, "", class: "flash-message", data: { is_flash_message: '' }

    FLASH_BS_TYPES.each_key do |type|
      if flash[type].present?
        result << javascript_tag("new FlashMessage('#{escape_javascript(flash[type])}', '#{FLASH_BS_TYPES[type]}')")
        break
      end
    end
    flash.discard

    result
  end


end
