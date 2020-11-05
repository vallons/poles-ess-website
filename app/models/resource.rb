class Resource < ApplicationRecord

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


  # Class Methods ==============================================================


  # Instance methods ====================================================


end
