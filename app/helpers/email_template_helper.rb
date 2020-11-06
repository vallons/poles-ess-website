# frozen_string_literal: true

module EmailTemplateHelper

  def t_mailer(mailer)
    I18n.t(mailer, scope: %i(email_template mailer))
  end

  def t_mail_name(mail_name)
    I18n.t(mail_name, scope: %i(email_template mail_name))
  end

end