# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    sequence(:email) {|n| "bonjour#{n}@example.com"}
    password {'password'}
    password_confirmation {'password'}
  end
end
