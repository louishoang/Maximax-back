# frozen_string_literal: true

FactoryBot.define do
  factory :product_property do
    product
    property
    description 'Red, Blue, Orange'
  end
end
