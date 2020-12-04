# frozen_string_literal: true

class KeyNumber < ApplicationRecord
  # Configurations =============================================================
  include Enablable
  include RichDescription

  acts_as_list

  include PgSearch::Model
  multisearchable against: [:title, :search_description, :source]

  # Associations ===============================================================

  # Callbacks ==================================================================
  validates :title, :number, presence: true

  # Scopes =====================================================================

  # Class Methods ==============================================================


  # Instance Methods ===========================================================

  # private #=====================================================================
end
