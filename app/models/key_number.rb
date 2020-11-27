# frozen_string_literal: true

class KeyNumber < ApplicationRecord
  # Configurations =============================================================
  include Enablable

  acts_as_list

  has_rich_text :description

  # Associations ===============================================================

  # Callbacks ==================================================================
  validates :title, :number, presence: true

  # Scopes =====================================================================

  # Class Methods ==============================================================


  # Instance Methods ===========================================================

  # private #=====================================================================
end
