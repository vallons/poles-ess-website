class Resource < ApplicationRecord
  include Enablable

  # Associations ===============================================================

  belongs_to :resourceable, polymorphic: true, inverse_of: :resource
  has_one_attached :document

  acts_as_list scope: [:resourceable_id, :resourceable_type]

  enum category: {
    document: 0,
    link: 1
  }

  # Validations ================================================================


  # Scopes ====================================================================

  # scope :by_theme, -> (val) {
  #   where(theme_id: val)
  # }
  # Class Methods ==============================================================


  # Instance methods ====================================================


end
