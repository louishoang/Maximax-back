# frozen_string_literal: true

class Property < ApplicationRecord
  has_many :product_properties
  has_many :product, through: :product_properties
  has_many :variant_properties
  has_many :variants, through: :variant_properties

  validates :identifying_name, presence: true, length: { maximum: 250 }
  validates :display_name, presence: true, length: { maximum: 165 }
end
