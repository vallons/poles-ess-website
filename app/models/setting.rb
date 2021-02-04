# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }
  has_one_attached :logo

  field :pole_name, type: :string, default: "Pôle ESS"
  field :pole_address, type: :string, default: "46 rue bidule"
  field :pole_city, type: :string, default: "35999 Ville-de-Bretagne"
  field :pole_phone, type: :string, default: "02 99 00 01 02"
  field :pole_mail, type: :string, default: "pole@pole.fr"
  field :baseline, type: :string, default: "Dynamiser les projets d'utilité sociale sur le territoire"
  field :newsletter_subscription_title, type: :string, default: "Inscrivez-vous à notre anti-newsletter"
  field :newsletter_subscription_description, type: :string, default: "Anti-newsletter ? Une info par lettre, soignée et choyée, à échéance régulière dans votre boîte aux lettres"
  field :logo_instance, type: :integer, default: 1, readonly: true
  field :logo_instance_primary, type: :integer, default: 1, readonly: true
  field :logo_instance_primary, type: :integer, default: 2, readonly: true
  field :admin_emails, type: :array, default: %w[bonjour@lassembleuse.fr]

  validates :logo, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'doit être une image' }

  def self.logo
    self.logo_instance.logo
  end

  def self.logo_instance
    self.where(var: :logo_instance).first_or_create
  end

  def self.logo_primary
    self.logo_instance_primary.logo
  end

  def self.logo_instance_primary
    self.where(var: :logo_instance_primary).first_or_create
  end
end
