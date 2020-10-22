# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    sequence(:title) {|n| "actu #{n}"}

    association :post_category
  end
end