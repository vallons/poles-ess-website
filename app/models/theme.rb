class Theme < ApplicationRecord

  include Seoable
  include Resourceable

  has_rich_text :description
  has_one_attached :image

  acts_as_list

  has_many :theme_interfaces, dependent: :destroy
  has_many :activities, through: :theme_interfaces, source: :themable,
           source_type: 'Activity'
  has_many :posts, through: :theme_interfaces, source: :themable,
          source_type: 'Post'

  # Validations ================================================================

  validates :title,
            :baseline,
            presence: true

  # Scopes ====================================================================

  scope :having_activities, -> { joins(:activities).distinct }
  scope :having_posts, -> { joins(:posts).distinct }

  # Instance methods ====================================================

  def key
    return self.title.parameterize
  end

end
