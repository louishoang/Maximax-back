# frozen_string_literal: true

FactoryBot.define do
  factory :product_property do
    product
    property
    value %w[Red Blue Orange].sample
  end
end
