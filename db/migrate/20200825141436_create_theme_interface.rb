class CreateThemeInterface < ActiveRecord::Migration[6.0]
  def change
    create_table :theme_interfaces do |t|
      t.references :theme, index: true
      t.references :themable, polymorphic: true, index: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
