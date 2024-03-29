# frozen_string_literal: true

FactoryBot.define do
  factory :inventory do
    count_on_hand             10_000
    count_pending_to_customer 1000
    count_pending_from_supplier 900
  end
end
