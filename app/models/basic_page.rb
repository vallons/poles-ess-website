# frozen_string_literal: true

class BasicPage < ApplicationRecord
  # Configurations =============================================================
  include Themable
  include Seoable
  include Resourceable
  include Enablable

  has_rich_text :content

  # Associations ===============================================================
  has_many :page_jointures, dependent: :destroy
  has_many :main_pages, through: :page_jointures

  # Callbacks ==================================================================
  validates :title, presence: true

  # Scopes =====================================================================

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

  # Instance Methods ===========================================================

  # private #=====================================================================
end
