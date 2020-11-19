class AddEnabledToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :enabled, :boolean, default: true
    add_column :formations, :enabled, :boolean, default: true
    add_column :formation_categories, :enabled, :boolean, default: true
    add_column :posts, :enabled, :boolean, default: true
    add_column :post_categories, :enabled, :boolean, default: true
    add_column :resources, :enabled, :boolean, default: true
    add_column :themes, :enabled, :boolean, default: true
  end
end
