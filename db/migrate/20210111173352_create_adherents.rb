class CreateAdherents < ActiveRecord::Migration[6.0]
  def change
    create_table :adherent_categories do |t|
      t.string :title
      t.integer :position
      t.timestamps null: false
    end
    create_table :adherents do |t|
      t.string :title
      t.string :link
      t.integer :position
      t.boolean :enabled, default: true
      t.references :adherent_category, index: true

      t.timestamps null: false
    end
  end

end
