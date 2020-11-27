# frozen_string_literal: true

module Resourceable
  extend ActiveSupport::Concern

  included do
    has_many :resources, -> { order(:position) }, as: :resourceable, inverse_of: :resourceable, dependent: :destroy
    accepts_nested_attributes_for :resources, reject_if: :all_blank, allow_destroy: true
  end
end
