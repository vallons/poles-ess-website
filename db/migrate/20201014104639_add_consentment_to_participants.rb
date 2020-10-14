class AddConsentmentToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :cgu_accepted_at, :datetime
  end
end
