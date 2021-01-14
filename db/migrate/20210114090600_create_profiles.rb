class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :title
      t.string :key
      t.string :baseline
      t.text :search_description
      t.integer :position
      t.boolean :enabled, default: true
      t.timestamps null: false
    end

    create_table :profile_interfaces do |t|
      t.references :profile, index: true
      t.references :profilable, polymorphic: true, index: true
      t.integer :position

      t.timestamps null: false
    end
  end
end
