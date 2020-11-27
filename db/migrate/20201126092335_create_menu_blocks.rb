class CreateMenuBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :menu_blocks do |t|
      t.string :title
      t.integer :position
      t.references :main_page, index: true
      t.references :theme, index: true

      t.timestamps null: false
    end
    create_table :menu_items do |t|
      t.string :title
      t.string :url
      t.integer :position
      t.references :menu_block, index: true

      t.timestamps null: false
    end
  end
end
