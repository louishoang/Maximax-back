# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name Faker::Commerce.product_name
    description 'product description'
    brand
    category
    permalink { name.underscore }
    available_at Time.now
    deleted_at nil
    meta_description 'Describe the variant'
    meta_keywords 'Key One, Key Two'
  end
end
