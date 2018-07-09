# frozen_string_literal: true

class ProductImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :url, :position, :thumbnail_url, :square_url

  def url
    rails_blob_url(object.file)
  end

  def thumbnail_url
    rails_representation_url(object.thumbnail)
  end

  def square_url
    rails_representation_url(object.square)
  end
end
