# frozen_string_literal: true

class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :variant_id, :quantity, :price, :name, :total, :sku, :image
end
