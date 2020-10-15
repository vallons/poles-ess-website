class ApplicationMailer < ActionMailer::Base
  default from: Setting.find_by(var: 'admin_emails').value.first
  layout 'mailer'
end
