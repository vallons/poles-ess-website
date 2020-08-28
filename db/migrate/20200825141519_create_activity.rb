class CreateActivity < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
