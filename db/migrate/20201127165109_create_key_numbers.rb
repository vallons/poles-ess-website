class CreateKeyNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :key_numbers do |t|
      t.string :title
      t.string :number
      t.string :source
      t.text :description
      t.integer :position
      t.boolean :enabled, default: true

      t.timestamps null: false
    end
  end
end
