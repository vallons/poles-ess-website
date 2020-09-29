class Theme < ApplicationRecord

  include Seoable

  has_rich_text :description
  has_one_attached :image

  acts_as_list

  has_many :theme_interfaces, dependent: :destroy
  has_many :activities, through: :theme_interfaces, source: :themable,
           source_type: 'Activity'

  # Validations ================================================================

  validates :title,
            :baseline,
            presence: true

  # Scopes ====================================================================
 

  # Instance methods ====================================================

  def key
    return self.title.parameterize
  end

end
