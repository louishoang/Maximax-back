# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :sku, :name, :price, :cost,
             :deleted_at, :master, :inventory_id

  attribute :option_value_names do |_attr|
    object.option_values.map(&:display_name).join(', ')
  end
end
