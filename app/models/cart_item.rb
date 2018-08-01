# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart, touch: true
  belongs_to :variant

  validates :variant_id, presence: true
  validates :cart_id, presence: true
  delegate :count_on_hand, to: :variant, allow_nil: true
  enum item_type: %i[shopping_cart wishlist]
  before_save :inactivate_zero_stock

  scope :inactive, -> { where(active: false) }

  def price
    variant.price
  end

  def name
    variant.product.name
  end

  def total
    price * quantity
  end

  def sku
    variant.sku
  end

  def image
    Rails.application.routes.url_helpers.rails_representation_url(variant.product.product_images.first.thumbnail)
  end

  def inactivate_zero_stock
    self.active = false if variant.count_on_hand == 0
  end
end
