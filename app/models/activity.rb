class Activity < ApplicationRecord

  include Themable
  include Seoable

  has_rich_text :description
  has_one_attached :image

  # Validations ================================================================

  validates :title,
            presence: true

  # Scopes ====================================================================


  # Instance methods ====================================================


end
