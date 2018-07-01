class ProductImageSerializer < ActiveModel::Serializer
  attributes :id, :url, :position

  def url
    Rails.application.routes.url_helpers.rails_blob_url(object.file)
  end
end
