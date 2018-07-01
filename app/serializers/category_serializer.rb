# frozen_string_literal: true

class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_id, :parent_name

  def parent_name
    object.parent_id.present? ? object.parent.name : ''
  end
end
