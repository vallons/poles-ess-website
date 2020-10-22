# frozen_string_literal: true

FactoryBot.define do
  factory :post_category do
    sequence(:title) {|n| "Categorie actu #{n}"}
  end
end
