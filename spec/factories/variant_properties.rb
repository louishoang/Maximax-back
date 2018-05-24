# frozen_string_literal: true

FactoryBot.define do
  factory :variant_property do
    description 'product description'
    variant
    property
  end
end
