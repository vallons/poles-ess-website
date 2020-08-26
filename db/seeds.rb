# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Référencement
%w[
  home
].each do |param|
  Seo.where(param: param).first_or_create
end

# Admin.create(email:"admin@admin.fr", password: "password")

# Settings

instance_logo = Setting.first_or_create(var: "logo_instance", value: 1)

instance_logo.logo.attach(io: File.open('public/default-logo.png'), filename: 'default-logo.png', content_type: 'image/png')
