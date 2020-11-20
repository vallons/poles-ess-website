# frozen_string_literal: true
class CreateBasicPages < ActiveRecord::Migration[6.0]
  def change
    create_table :basic_pages do |t|
      t.string :title
      t.text :content
      t.integer :position
      t.boolean :enabled, default: false
      t.string :key

      t.timestamps null: false
    end
  end
end