# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product
  belongs_to :inventory
  has_many :variant_properties
  has_many :properties, through: :variant_properties

  validates :price,       presence: true
  validates :cost,        presence: true
  validates :product_id,  presence: true
  validates :sku,         presence: true, length: { maximum: 255 }

  delegate  :brand, to: :product, allow_nil: true
end
