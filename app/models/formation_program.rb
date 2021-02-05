class FormationProgram < ApplicationRecord
  include Enablable

  has_one_attached :document

  acts_as_list

  # Validations ================================================================

  validates :title, :document,   presence: true

  # Scopes ====================================================================

  # Instance methods ====================================================

  # Class Methods ==============================================================

end
