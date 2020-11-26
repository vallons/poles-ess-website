# frozen_string_literal: true

class MainPage < ApplicationRecord
  # Configurations =============================================================
  include Seoable
  include Resourceable
  include Enablable

  has_rich_text :description
  has_one_attached :image

  acts_as_list

  has_many :page_jointures, dependent: :destroy
  has_many :basic_pages, through: :page_jointures

  # Associations ===============================================================

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
    self.order(created_at: :desc)
  end

  # Instance Methods ===========================================================

  # private #=====================================================================
end
