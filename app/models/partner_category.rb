# frozen_string_literal: true
class PartnerCategory < ApplicationRecord
  include Seoable
  include Enablable

  # Configurations =============================================================
  acts_as_list

  # Associations ===============================================================
  has_many :partners, -> { order(:position) }, dependent: :restrict_with_exception

  # Callbacks ==================================================================

  validates :title, presence: true

  # Scopes =====================================================================
  scope :having_partners, -> { joins(:partners).distinct }

  # Class Methods ==============================================================

  def self.apply_filters(params)
    klass = self
  end

  def self.apply_sorts(params)
    self.order(position: :asc)
  end


  # Instance Methods ===========================================================

  # private #=====================================================================
end
