# frozen_string_literal: true

class ProductProperty < ApplicationRecord
  belongs_to :product
  belongs_to :property

  validates :product_id, uniqueness: { scope: :property_id }
  validates :property_id, presence: true

  scope :with_product_id, lambda { |product_id|
    joins(:product).where('products.permalink = ?', product_id) if product_id
  }
end
