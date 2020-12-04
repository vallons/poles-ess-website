# frozen_string_literal: true

class MainPage < ApplicationRecord
  # Configurations =============================================================
  include Seoable
  include Resourceable
  include Enablable
  include RichDescription

  include PgSearch::Model
  multisearchable against: [:title, :baseline, :search_description]

  has_one_attached :image

  acts_as_list

  # Associations ===============================================================
  has_many :page_jointures, dependent: :destroy
  has_many :basic_pages, through: :page_jointures

  has_many :menu_blocks, -> { order(:position) }, inverse_of: :main_page, dependent: :destroy
  accepts_nested_attributes_for :menu_blocks, reject_if: :all_blank
  has_many :menu_items, -> { order(:position) }, through: :menu_blocks

  # Callbacks ==================================================================
  validates :title, presence: true

  # Scopes =====================================================================

  # Class Methods ==============================================================
  def self.apply_filters(params)
    [

    ].inject(all) do |relation, filter|
      next relation unless params[filter].present?
      relation.send(filter, params[filter])
    end
  end

  def self.apply_sorts(params)
    order(created_at: :desc)
  end

  # Instance Methods ===========================================================

  # private #=====================================================================
end
