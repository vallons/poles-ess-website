# frozen_string_literal: true

class PostCategory < ApplicationRecord
  include Seoable
  include Enablable

  # Configurations =============================================================
  acts_as_list

  # Associations ===============================================================
  has_many :posts, dependent: :restrict_with_exception

  # Callbacks ==================================================================

  validates :title, presence: true

  # Scopes =====================================================================
  scope :having_posts, -> { joins(:posts).distinct }

  # Class Methods ==============================================================

  def self.apply_filters(params)
    klass = self

    klass.apply_sorts(params)
  end

  # Instance Methods ===========================================================

  # private #=====================================================================
end
