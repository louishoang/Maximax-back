class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :product_keywords, :available_at,
             :deleted_at, :meta_keywords, :meta_description, :category_id, :permalink,
             :brand_id, :status, :sku, :price

  has_many :product_images
end
