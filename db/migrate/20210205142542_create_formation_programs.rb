class CreateFormationPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :formation_programs do |t|
      t.string :title
      t.integer :position
      t.boolean :enabled, default: true
      t.timestamps null: false
    end
  end
end
