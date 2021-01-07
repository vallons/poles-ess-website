class AddParentPageIdToMainPages < ActiveRecord::Migration[6.0]
  def up
    add_reference :main_pages, :parent_page, index: true
    add_column :main_pages, :key, :string
    drop_table :page_jointures
  end
  
  def down
    remove_reference :main_pages, :parent_page, index: true
    remove_column :main_pages, :key, :string
    create_table :page_jointures do |t|
      t.references :basic_page, index: true
      t.references :main_page, index: true
      t.timestamps null: false
    end
  end
end
