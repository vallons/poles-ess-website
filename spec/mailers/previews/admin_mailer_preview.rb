# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  def new_subscription
    AdminMailer.with(subscription: Subscription.last).new_subscription
  end

end