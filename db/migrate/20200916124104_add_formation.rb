class AddFormation < ActiveRecord::Migration[6.0]
  def change

    create_table :formation_categories do |t|
      t.string :title
      t.integer :position
      t.timestamps null: false
    end

    create_table :formations do |t|
      t.string :title
      t.text :description
      t.references :formation_category, index: true
      t.string :address
      t.string :zipcode
      t.string :city
      t.text :speaker
      t.integer :tickets_count
      t.float :cost

      t.timestamps null: false
    end

    create_table :schedules do |t|
      t.tsrange :time_range
      t.references :schedulable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
