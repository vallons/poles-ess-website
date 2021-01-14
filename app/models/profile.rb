# frozen_string_literal: true
class Profile < ApplicationRecord
  include Seoable
  include Resourceable
  include Enablable
  include RichDescription

  include PgSearch::Model
  multisearchable against: [:title, :baseline, :search_description]

  has_one_attached :image
  has_one_attached :icon

  acts_as_list

  has_many :profile_interfaces, dependent: :destroy
  has_many :activities, through: :profile_interfaces, source: :profilable,
           source_type: 'Activity'
  has_many :posts, through: :profile_interfaces, source: :profilable,
          source_type: 'Post'

  has_many :menu_blocks, -> { order(:position) }, inverse_of: :profile, dependent: :destroy
  accepts_nested_attributes_for :menu_blocks, reject_if: :all_blank
  has_many :menu_items, -> { order(:position) }, through: :menu_blocks

  # Validations ================================================================

  validates :title,
            :baseline,
            presence: true

  # Scopes ====================================================================

  scope :having_activities, -> { joins(:activities).distinct }
  scope :having_posts, -> { joins(:posts).distinct }

  # Instance methods ====================================================
end
