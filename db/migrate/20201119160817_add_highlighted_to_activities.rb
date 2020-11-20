class AddHighlightedToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :highlighted, :boolean, default: false
    add_column :activities, :home_title, :string
  end
end
