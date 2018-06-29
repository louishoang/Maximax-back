# frozen_string_literal: true

class Api::V1::Admin::ProductImagesController < Api::V1::Admin::BaseController
  def create
    product = Product.friendly.find(params[:product_id])
    authorize! :edit, product

    product.product_images.build.tap do |img|
      img.file.attach(params[:file])
    end.save

    head :ok
  end

  def destroy
    image = ProductImage.find(params[:id])
    authorize! :destroy, :product_images
    return(head :ok) if image.destroy
    head :bad_request
  end
end
