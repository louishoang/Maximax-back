# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :product_keywords, :available_at,
             :deleted_at, :meta_keywords, :meta_description, :category_id, :permalink,
             :brand_id, :status, :sku, :price, :option_type_ids

  has_many :product_images
end
