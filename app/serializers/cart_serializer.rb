# frozen_string_literal: true

class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  has_many :cart_items
end
