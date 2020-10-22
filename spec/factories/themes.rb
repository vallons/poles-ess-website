# frozen_string_literal: true

FactoryBot.define do

  factory :theme do
    sequence(:title) {|n| "Theme #{n}"}
    sequence(:baseline) {|n| "Slogan theme #{n}"}
  end
end
