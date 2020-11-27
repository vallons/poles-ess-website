# frozen_string_literal: true

class MenuItem < ApplicationRecord

  # Configurations =============================================================
  acts_as_list

  # Associations ===============================================================
  belongs_to :menu_block, inverse_of: :menu_items

  # Callbacks ==================================================================
  validates :title, :url, presence: true

  # Scopes =====================================================================

  # Class Methods ==============================================================

  def self.apply_filters(params)
    klass = self
  end

  # Instance Methods ===========================================================

  # private #=====================================================================
end
