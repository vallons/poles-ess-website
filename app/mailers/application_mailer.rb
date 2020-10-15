class ApplicationMailer < ActionMailer::Base
  default from: Setting.admin_emails.first
  layout 'mailer'
end
