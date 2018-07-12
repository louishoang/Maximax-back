# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :sku, :name, :price, :cost,
             :deleted_at, :master, :inventory_id

  attribute :inventory_attributes do |_attr|
    i = object.inventory
    {
      vendor_link: i.vendor_link,
      vendor_sku: i.vendor_sku,
      count_on_hand: i.count_on_hand
    }
  end

  attribute :option_list do |_attr|
    object.option_values.each_with_object({}) do |ov, hash|
      hash[ov.option_type.display_name] = ov.display_name
    end
  end
end
