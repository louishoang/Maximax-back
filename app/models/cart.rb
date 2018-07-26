# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  after_touch :prevent_cart_item_duplication

  enum cart_type: %i[shopping_cart wishlist]
  validates :user_id, presence: true
  accepts_nested_attributes_for :cart_items, allow_destroy: true
  scope :shopping_carts, -> { where(cart_type: :shopping_cart) }

  def sub_total
    cart_items.map(&:total).sum
  end

  def number_of_shopping_cart_items
    cart_items.map(&:quantity).sum
  end

  def filter_inactive_items
    cart_items.inactive.destroy_all
  end

  private

  # This method ensure two cart_item with the same variant_id
  # will be combined into one cart_item with 2 count (quantity)

  def prevent_cart_item_duplication
    duplicated = cart_items.group(:variant_id).having('COUNT(variant_id) > 1').count
    duplicated.each do |g|
      cart_items.where(variant_id: g[0]).destroy_all
      CartItem.create(cart_id: id, variant_id: g[0], quantity: g[1])
    end
  end
end
