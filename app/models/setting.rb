# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }
  has_one_attached :logo
  has_one_attached :logo_primary

  field :pole_name, type: :string
  field :pole_address, type: :string
  field :pole_address_complementary, type: :string
  field :pole_city, type: :string
  field :pole_phone, type: :string
  field :pole_mail, type: :string
  field :baseline, type: :string
  field :newsletter_subscription_title, type: :string
  field :newsletter_subscription_description, type: :string
  field :contact_bloc_description, type: :string
  field :contact_bloc_button, type: :string
  field :logo_instance, type: :integer, default: 1, readonly: true
  field :logo_instance_primary, type: :integer, default: 2, readonly: true
  field :admin_emails, type: :array

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
