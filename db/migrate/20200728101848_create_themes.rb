class CreateThemes < ActiveRecord::Migration[6.0]
  def change
    create_table :themes do |t|
      t.string :title
      t.string :baseline
      t.text :description
      t.timestamps null: false
    end
  end
end
