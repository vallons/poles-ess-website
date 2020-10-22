# frozen_string_literal: true

module Themable
  extend ActiveSupport::Concern

  included do
    has_many :theme_interfaces, as: :themable, dependent: :destroy, inverse_of: :themable
    has_many :themes, through: :theme_interfaces
  end
end