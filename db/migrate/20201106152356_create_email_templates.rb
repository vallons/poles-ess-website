class CreateEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :email_templates do |t|
      t.text :body
      t.string :mailer
      t.string :mail_name

      t.timestamps
    end
  end
end
