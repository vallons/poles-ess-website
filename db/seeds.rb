# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin ------------------------------------------------
Admin.where(email: "bonjour@lassembleuse.fr").first_or_create(password: "password") if %w[development test].include?(Rails.env)

# Référencement ---------------------------------------
%w[
  home
].each do |param|
  Seo.where(param: param).first_or_create
end


# Settings ----------------------------------------------

instance_logo = Setting.first_or_create(var: "logo_instance", value: 1)

instance_logo.logo.attach(io: File.open('public/default-logo.png'), filename: 'default-logo.png', content_type: 'image/png')

EmailTemplate.where(mailer: "ParticipantMailer", mail_name: "new_subscription").first_or_create(body: "Le pôle vous recontactera rapidement pour préciser les détails pratiques et le règlement.")

# Basïc Pages ==================================================
[
  { key: 'data_policy', title: "Politique de confidentialité", enabled: true },
  { key: 'legal_mentions', title: "Mentions légales", enabled: true },
  { key: 'key_numbers', title: "Chiffres-clés", enabled: true },
  { key: 'ess_map', title: "Cartographie", enabled: true },
  { key: 'membership', title: "Adhérer au pôle", enabled: true },
].each do |option|
  BasicPage.where(key: option[:key]).first_or_create(
    enabled: option[:enabled], 
    title: option[:title]
  )
end