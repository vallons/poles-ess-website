class ThemeInterface < ApplicationRecord

  acts_as_list scope: [:theme_id, :themable_type]

  # Associations ===============================================================
  belongs_to :themable, polymorphic: true
  belongs_to :theme

  # Scopes ====================================================================

  scope :by_theme, -> (val) {
    where(theme_id: val)
  }
  scope :by_themable_type, -> (val) {
    where(themable_type: val)
  }


  # Instance methods ====================================================


end
