# frozen_string_literal: true

module Enablable
  extend ActiveSupport::Concern

  included do
    scope :enabled, -> { where(enabled: true) }
    scope :disabled, -> { where(enabled: false) }
  end
end