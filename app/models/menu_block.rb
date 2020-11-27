# frozen_string_literal: true

class MenuBlock < ApplicationRecord

  # Configurations =============================================================
  acts_as_list

  # Associations ===============================================================
  has_many :menu_items, -> { order(:position) }, inverse_of: :menu_block, dependent: :destroy
  accepts_nested_attributes_for :menu_items, reject_if: :all_blank, allow_destroy: true
  belongs_to :theme, inverse_of: :menu_blocks, optional: true
  belongs_to :main_page, inverse_of: :menu_blocks, optional: true

  # Callbacks ==================================================================

  def belongs_to_main_page_or_theme
    return true if main_page || theme

    errors.add(:base, :belongs_to_main_page_or_theme)
    false
  end
  validate :belongs_to_main_page_or_theme

  # Scopes =====================================================================
  scope :having_menu_items, -> { joins(:menu_items).distinct }

  # Class Methods ==============================================================

  def self.apply_filters(params)
    klass = self
  end

  # Instance Methods ===========================================================

  # private #=====================================================================
end
