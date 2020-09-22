class Formation < ApplicationRecord

  include Seoable

  has_rich_text :description
  has_one_attached :image

  belongs_to :formation_category
  has_many :formation_sessions

  # Validations ================================================================

  validates :title, :formation_category,
            presence: true

  # Scopes ====================================================================

  scope :by_formation_category, -> (val) {
    where(formation_category_id: val)
  }

  # Instance methods ====================================================

  # Class Methods ==============================================================

  def self.apply_filters(params)
    [
      :by_formation_category,
    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
      self.order(created_at: :desc)
  end

end
