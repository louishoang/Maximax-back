# frozen_string_literal: true

class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :variant_id, :quantity, :price, :name,
             :total, :sku, :image, :count_on_hand, :active, :item_type

  attribute :option_list do |_attr|
    object.variant.option_values.each_with_object({}) do |ov, hash|
      hash[ov.option_type.display_name] = ov.display_name
    end
  end
end
