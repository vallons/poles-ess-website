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

  validates :title, presence: true
  validates :link, presence: true, if: ->(r) { r.link? }
  validates :document, presence: true, if: ->(r) { r.document? }

  # Scopes ====================================================================

  # scope :by_theme, -> (id) {
  #   where(resourceable_type: "Theme").where(resourceable_id: id)
  # }
  # Class Methods ==============================================================


  # Instance methods ====================================================


end
