class ProfileInterface < ApplicationRecord
  acts_as_list scope: [:profile_id, :profilable_type]

  # Associations ===============================================================
  belongs_to :profilable, polymorphic: true
  belongs_to :profile

  # Scopes ====================================================================

  scope :by_profile, -> (val) {
    where(profile_id: val)
  }
  scope :by_profilable_type, -> (val) {
    where(profilable_type: val)
  }

  # Instance methods ====================================================
end
