# frozen_string_literal: true

module Themable
  extend ActiveSupport::Concern

  included do
    has_many :theme_interfaces, as: :themable, dependent: :destroy, inverse_of: :themable
    has_many :themes, through: :theme_interfaces

    scope :by_theme, -> (val) {
      joins(:theme_interfaces).merge(ThemeInterface.by_theme(val))
    }

    scope :order_by_theme_interface_position, -> {
      joins(:theme_interfaces).merge(ThemeInterface.order(position: :asc)).uniq
    }
  end
end