# frozen_string_literal: true

class ProductPropertySerializer < ActiveModel::Serializer
  attributes :id, :value, :position, :property_id

  attribute :property_name do |_attr|
    object.property.display_name
  end
end
