# frozen_string_literal: true

FactoryBot.define do

  factory :formation do
    sequence(:title) {|n| "formation#{n}"}

    association :formation_category
    schedules{ build_list :schedule, 1 }

  end
end
