# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    user
    cart_type :shopping_cart
  end
end
