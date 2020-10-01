class AddParticipants < ActiveRecord::Migration[6.0]
  def change

    create_table :subscriptions do |t|
      t.references :formation, index: true
      t.float :cost

      t.timestamps null: false
    end

    create_table :participants do |t|
      t.references :subscription, index: true
      t.string :firstname
      t.string :lastname
      t.string :organization
      t.string :email
      t.string :phone
      t.integer :status, default: 0

      t.timestamps null: false
    end

  end
end
