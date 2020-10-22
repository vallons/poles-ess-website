# frozen_string_literal: true

class AddPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :post_categories do |t|
      t.string :title
      t.integer :position
      t.string :type

      t.timestamps
    end

    create_table :posts do |t|
      t.string :title
      t.text :description

      t.datetime :published_at
      t.datetime :expired_at

      t.references :post_category, index: true

      t.timestamps
    end


  end
end
