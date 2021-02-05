class Event < ApplicationRecord
  include Seoable
  include Enablable
  include Schedulable

  # Validations ================================================================

  validates :title, :schedules,
            presence: true

  # Scopes ====================================================================

  # Instance methods ====================================================

  # Class Methods ==============================================================

end
