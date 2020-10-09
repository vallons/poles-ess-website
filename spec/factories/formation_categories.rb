# frozen_string_literal: true

FactoryBot.define do

  factory :formation_category do
    sequence(:title) {|n| "Categorie #{n}"}
  end
end
