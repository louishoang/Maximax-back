class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :cart_type

  has_many :cart_items
end
