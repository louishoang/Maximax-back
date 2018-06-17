# frozen_string_literal: true

class Api::V1::Admin::ProductsController < Api::V1::Admin::BaseController
  def index
    products = Product.all
    render json: products.as_json
  end

  def create
    product = Product.new(product_params)
    authorize! :create, product

    if product.save
      render json: { id: product.permalink }, status: :created
    else
      render json: { error_message: product.errors.full_messages.join('\n') },
             status: :bad_request
    end
  end

  def update
    product = Product.friendly.find(params[:id])
    authorize! :edit, product

    if product.update_attributes(product_params)
      render json: { id: product.permalink }, status: :ok
    else
      render json: { error_message: product.errors.full_messages.join('\n') },
             status: :bad_request
    end
  end

  def destroy
    product = Product.friendly.find(params[:id])
    authorize! :destroy, product
    product.deleted_at ||= Time.zone.now
    product.save
    head :ok
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id,
                                    :permalink, :available_at, :deleted_at,
                                    :meta_keywords, :meta_description, :brand_id, product_keywords: [])
  end
end
