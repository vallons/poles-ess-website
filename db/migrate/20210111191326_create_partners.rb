class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_categories do |t|
      t.string :title
      t.integer :position
      t.timestamps null: false
    end
    create_table :partners do |t|
      t.string :title
      t.string :link
      t.integer :position
      t.boolean :enabled, default: true
      t.references :partner_category, index: true

      t.timestamps null: false
    end
  end
end
