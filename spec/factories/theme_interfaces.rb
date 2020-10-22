# frozen_string_literal: true

FactoryBot.define do

  factory :theme_interface do
    association :theme
    for_post

    trait :for_post do
      association :commentable, factory: :post
    end

    trait :for_activity do
      association :commentable, factory: :activity
    end
  end
end
