# frozen_string_literal: true

module Profilable
  extend ActiveSupport::Concern

  included do
    has_many :profile_interfaces, as: :profilable, dependent: :destroy, inverse_of: :profilable
    has_many :profiles, through: :profile_interfaces

    scope :by_profile, -> (val) {
      joins(:profile_interfaces).merge(ProfileInterface.by_profile(val))
    }

    scope :order_by_profile_interface_position, -> {
      joins(:profile_interfaces).merge(ProfileInterface.order(position: :asc)).uniq
    }
  end
end