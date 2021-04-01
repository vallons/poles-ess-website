# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include Rails.application.routes.url_helpers

# Admin ------------------------------------------------
Admin.where(email: "bonjour@lassembleuse.fr").first_or_create(password: "password") if %w[development test].include?(Rails.env)

# Référencement ---------------------------------------
%w[
  home
].each do |param|
  Seo.where(param: param).first_or_create
end


# Settings ----------------------------------------------

Setting.logo_instance = 1  if Setting.logo_instance.blank?
Setting.logo_instance.logo.attach(io: File.open('public/logo.png'), filename: 'logo.png', content_type: 'image/png')
Setting.logo_instance_primary = 1  if Setting.logo_instance_primary.blank?
Setting.logo_instance_primary.logo.attach(io: File.open('public/logo-primary.png'), filename: 'logo-primary.png', content_type: 'image/png')
Setting.pole_name = "Pôle ESS Vallons Solidaires"                        if Setting.pole_name.blank?
Setting.pole_address = "Maison des associations"      if Setting.pole_address.blank?
Setting.pole_address_complementary = "46 rue bidule"  if Setting.pole_address_complementary.blank?
Setting.pole_city = "35999 Ville-de-Bretagne"         if Setting.pole_city.blank?
Setting.pole_phone = "02 99 00 01 02"                 if Setting.pole_phone.blank?
Setting.pole_mail = "pole@pole.fr"                    if Setting.pole_mail.blank?
Setting.baseline = "Dynamiser les projets d'utilité sociale sur le territoire des Vallons de Vilaine"    if Setting.baseline.blank?
Setting.newsletter_subscription_title = "Inscrivez-vous à notre anti-newsletter"  if Setting.newsletter_subscription_title.blank?
Setting.newsletter_subscription_description = "Anti-newsletter ? Une info par lettre, soignée et choyée, à échéance régulière dans votre boîte aux lettres" if Setting.newsletter_subscription_description.blank?
Setting.contact_bloc_description = "Vous avez des tonnes de question ? Vous souhaitez mieux identifier ce qui existe sur le territoire ?" if Setting.contact_bloc_description.blank?
Setting.contact_bloc_button = "Contacter le pôle" if Setting.contact_bloc_button.blank?
Setting.admin_emails = %w[bonjour@lassembleuse.fr]    if Setting.admin_emails.blank?

EmailTemplate.where(mailer: "ParticipantMailer", mail_name: "new_subscription").first_or_create(body: "Le pôle vous recontactera rapidement pour préciser les détails pratiques et le règlement.")

# Basic Pages ==================================================
[
  { key: 'data_policy', title: 'Politique de confidentialité', enabled: true },
  { key: 'legal_mentions', title: 'Mentions légales', enabled: true },
  { key: 'cgu', title: 'Conditions d\'utilisation', enabled: true },
  { key: 'contact', title: 'Contact', enabled: true },
].each do |option|
  BasicPage.where(key: option[:key]).first_or_create(
    enabled: option[:enabled],
    title: option[:title]
  )
end

# Themes ==================================================
[
  { title: 'Découvrir', baseline: 'Découvrir et faire connaître une économique alternative: sociale, solidaire et écologique', position: 1 },
  { title: "Coopérer", baseline: 'Soutenir et accompagner des projets créatifs, collectifs et coopératifs', position: 2 },
  { title: "Entreprendre", baseline: "Etre accompagné.e pour créer ou développer mon projet d’utilité sociale", position: 3 },
  { title: "Dynamiser", baseline: "Pour faire réseau, créer du lien et faire connaître les projets à forte valeur humaine !", position: 4 },
  { title: "Se former", baseline: "Pour accompagner les associations et entrepreneur.e.s du territoire dans leurs fonctions et missions", position: 5 },
].each do |option|
  Theme.where(title: option[:title]).first_or_create(
    baseline: option[:baseline],
    position: option[:position]
  )
end

# Profiles ==================================================
[
  { title: 'Association', key: 'association', baseline: 'Voir ce que le pôle ESS peut proposer aux associations', position: 1 },
  { title: "Porteur de projet", key: 'porteur', baseline: "Voir ce que le pôle ESS peut proposer aux porteurs de projet", position: 2 },
  { title: "Collectivité", key: 'collectivite', baseline: 'Voir ce que le pôle ESS peut proposer aux collectivités', position: 3 },
  { title: "Entreprise", key: 'entreprise', baseline: 'Voir ce que le pôle ESS peut proposer aux entreprises', position: 4 },
  { title: "École", key: 'ecole', baseline: 'Voir ce que le pôle ESS peut proposer aux écoles', position: 5 },
].each do |option|
  Profile.where(key: option[:key]).first_or_create(
    title: option[:title],
    baseline: option[:baseline],
    position: option[:position]
  )
end


# Main Pages ==================================================
[
  { title: 'Le pôle', baseline: 'Une structure au service du territoire', position: 1, child_pages: [
    { key: nil, title: 'Missions', enabled: true, position: 1 },
    { key: 'staff_member', title: 'Equipe', enabled: true, position: 2 },
    { key: 'adherent', title: 'Adhérents', enabled: true, position: 3 },
    { key: 'partner', title: 'Partenaires', enabled: true, position: 4 },
    { key: 'membership', title: 'Adhérer au pôle', enabled: true, position: 5 },
  ] },
  { title: "L'ESS", baseline: "Découvrez l'économie sociale et solidaire", position: 2, child_pages: [
    { key: nil, title: "C'est quoi l'ESS?", enabled: true, position: 1 },
    { key: 'key_number', title: 'Chiffres-clés', enabled: true, position: 2 },
    { key: 'ess_map', title: 'Cartographie', enabled: true, position: 3 },
  ] },
].each do |option|
  main_page = MainPage.where(title: option[:title]).first_or_create(
    baseline: option[:baseline],
    position: option[:position]
  )
  option[:child_pages].each do |child_page_h|
    main_page.child_pages.where(key: child_page_h[:key]).first_or_create(
      title: child_page_h[:title],
      enabled: child_page_h[:enabled],
      position: child_page_h[:position]
    )
  end
end

# Menu Items ==================================================

[
  { theme: 'Découvrir', menu_blocks: [
    { title: "", position: 2, menu_items: [
      { title: "Chiffre-clés", url: key_numbers_path, position: 1},
      { title: "Ressources", url: resources_path, position: 2},
      { title: "Actualités", url: posts_path, position: 3}
      ]
    }
    ]
  },
  { theme: 'Entreprendre', menu_blocks: [
    { title: "", position: 2, menu_items: [
      { title: "Chiffre-clés", url: key_numbers_path, position: 1},
      { title: "Ressources", url: resources_path, position: 2},
      { title: "Actualités", url: posts_path, position: 3}
    ] }
    ]
  }
].each do |option|
  theme = Theme.where(title: option[:theme]).first
  next unless theme.present?

  option[:menu_blocks].each do |menu_block_h|
    menu_block = theme.menu_blocks.where(title: menu_block_h[:title]).first_or_create(position: menu_block_h[:position])
    menu_block_h[:menu_items].each do |menu_item_h|
      menu_block.menu_items.where(title: menu_item_h[:title]).first_or_create(
        url: menu_item_h[:url],
        position: menu_item_h[:position]
      )
    end
  end
end

[
  { main_page: 'Le pôle', menu_blocks: [
    { title: "Les composantes du pôle", position: 1, menu_items: [
      { title: "Présentation", url: "#", position: 1 },
      { title: "Missions", url: "#", position: 2 },
      { title: "Equipe", url: staff_members_path, position: 3 },
      { title: "Adhérents", url: adherents_path, position: 4 },
      { title: "Partenaires", url: partners_path, position: 5 }
    ] },
    { title: "Agir avec le pôle", position: 2, menu_items: [
      { title: "Adhérer au pôle", url: main_page_path(MainPage.find_by(key: 'membership')), position: 1},
      { title: "Se former", url: formations_path, position: 2},
      { title: "Contacter le pôle", url: basic_page_path(BasicPage.find_by(key: 'contact')), position: 3}
      ]
    }
    ]
  },
  { main_page: "L'ESS", menu_blocks: [
    { title: "L'ESS sur le territoire", position: 1, menu_items: [
      { title: "Chiffre-clés", url: key_numbers_path, position: 1 },
      { title: "Cartographie", url: main_page_path(MainPage.find_by(key: 'ess_map')), position: 2 },
      { title: "Exemples de projets", url: "#", position: 3 }
    ] },
    { title: "L'ESS en général", position: 2, menu_items: [
      { title: "C'est quoi l'ESS ?", url: "#", position: 1},
      { title: "Le réseau des pôles ESS", url: "#", position: 2},
      { title: "Ressources", url: "#", position: 3}
    ] }
    ]
  }
].each do |option|
  main_page = MainPage.where(title: option[:main_page]).first
  next unless main_page.present?

  option[:menu_blocks].each do |menu_block_h|
    menu_block = main_page.menu_blocks.where(title: menu_block_h[:title]).first_or_create(position: menu_block_h[:position])
    menu_block_h[:menu_items].each do |menu_item_h|
      menu_block.menu_items.where(title: menu_item_h[:title]).first_or_create(
        url: menu_item_h[:url],
        position: menu_item_h[:position]
      )
    end
  end
end