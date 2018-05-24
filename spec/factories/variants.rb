# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    sku Faker::Code.imei
    product
    inventory
    price Faker::Commerce.price
    cost Faker::Commerce.price * 70 / 100
    deleted_at nil
    master false
  end
end
