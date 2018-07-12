# frozen_string_literal: true

class Api::V1::ProductsController < Api::V1::BaseController
  skip_before_action :authenticate_api_v1_user!

  def show
    product = Product.includes(product_images: [file_attachment: [:blob]])
                     .friendly.find(params[:id])

    render json: product, serializer: ProductWithVariantSerializer
  end
end
