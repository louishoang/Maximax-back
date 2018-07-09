# frozen_string_literal: true

class SimpleProductSerializer < ActiveModel::Serializer
  attributes :name, :permalink, :price

  has_many :product_images
end
