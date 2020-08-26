class ThemeInterface < ApplicationRecord

  # Associations ===============================================================
  belongs_to :themable, polymorphic: true
  belongs_to :theme

  # Scopes ====================================================================
 

  # Instance methods ====================================================


end
