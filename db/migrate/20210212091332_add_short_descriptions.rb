class AddShortDescriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :main_pages, :short_description, :string
    add_column :activities, :short_description, :string
    add_column :themes, :short_description, :string
    add_column :profiles, :short_description, :string

    up_only do
      MainPage.all.each{ |item| item.update_columns(short_description: item.description.to_plain_text.truncate(250))}
      Activity.all.each{ |item| item.update_columns(short_description: item.description.to_plain_text.truncate(250))}
      Theme.all.each{ |item| item.update_columns(short_description: item.description.to_plain_text.truncate(250))}
      Profile.all.each{ |item| item.update_columns(short_description: item.description.to_plain_text.truncate(250))}
    end
  end

end
