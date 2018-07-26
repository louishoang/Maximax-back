# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :cart, touch: true
  belongs_to :variant

  validates :variant_id, presence: true
  validates :cart_id, presence: true

  scope :inactive, -> { joins(variant: :inventory).where('inventories.count_on_hand <= ?', 0) }

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
end
