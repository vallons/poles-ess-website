class CreateStaffMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :staff_member_categories do |t|
      t.string :title
      t.integer :position
      t.timestamps null: false
    end
    create_table :staff_members do |t|
      t.string :firstname
      t.string :lastname
      t.integer :position
      t.boolean :enabled, default: true
      t.references :staff_member_category, index: true

      t.timestamps null: false
    end
  end
end
