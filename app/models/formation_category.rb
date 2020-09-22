class FormationCategory < ApplicationRecord

  include Seoable

  acts_as_list

  has_many :formations, dependent: :restrict_with_exception

  # Validations ================================================================

  validates :title,
  presence: true

  # Scopes ====================================================================

  scope :having_formations, -> { joins(:formations).uniq }

  # Instance methods ====================================================

  # Class Methods ==============================================================

  def self.apply_sorts(params)
      self.order(created_at: :desc)
  end

end
