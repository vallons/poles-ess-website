class Theme < ApplicationRecord

  has_rich_text :description

  # Validations ================================================================

  validates :title,
            :baseline,
            presence: true

  # Scopes ====================================================================
 

  # Instance methods ====================================================

  def key
    return self.title.parameterize
  end

end
