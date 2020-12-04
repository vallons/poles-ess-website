class AddSearchableDescriptions < ActiveRecord::Migration[6.0]
  def change
    rename_column :activities, :description, :search_description
    rename_column :basic_pages, :content, :search_description
    rename_column :formations, :description, :search_description
    rename_column :key_numbers, :description, :search_description
    rename_column :main_pages, :description, :search_description
    rename_column :posts, :description, :search_description
    rename_column :themes, :description, :search_description

    up_only do
      Activity.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
      BasicPage.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
      Formation.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
      KeyNumber.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
      MainPage.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
      Post.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
      Theme.all.each{ |item| item.update_columns(search_description: item.description.to_plain_text)}
    end
  end
end
