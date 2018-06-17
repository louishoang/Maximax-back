# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :product
  belongs_to :inventory

  validates :price,       presence: true
  validates :cost,        presence: true
  validates :product_id,  presence: true
  validates :sku,         presence: true, length: { maximum: 255 }

  delegate  :brand, to: :product, allow_nil: true
end
