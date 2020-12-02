class Activity < ApplicationRecord
  include Themable
  include Seoable
  include Enablable
  include Resourceable

  has_rich_text :description
  has_one_attached :image

  # Validations ================================================================

  validates :title,
            presence: true
  validates :home_title,
            presence: true, if: :highlighted?

  # Scopes ====================================================================

  scope :highlighted, -> { where(highlighted: true) }

  # Instance methods ====================================================

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_theme,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
    if params[:by_theme].present?
      self.order_by_theme_interface_position
    else
      self.order(created_at: :desc)
    end
  end

end
