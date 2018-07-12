# frozen_string_literal: true

class InventorySerializer < ActiveModel::Serializer
  attributes :vendor_sku, :vendor_link, :count_on_hand
end
