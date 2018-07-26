# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    cart
    variant
    quantity 1
  end
end