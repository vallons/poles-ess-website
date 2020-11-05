class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.string :title
      t.integer :position
      t.integer :category, default: 0
      t.string :link
      t.references :resourceable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
