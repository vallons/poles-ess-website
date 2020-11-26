class CreateMainPages < ActiveRecord::Migration[6.0]
  def change
    create_table :main_pages do |t|
      t.string :title
      t.string :baseline
      t.text :description
      t.integer :position
      t.boolean :enabled, default: true

      t.timestamps null: false
    end

    create_table :page_jointures do |t|
      t.references :basic_page, index: true
      t.references :main_page, index: true
      t.timestamps null: false
    end
  end
end
