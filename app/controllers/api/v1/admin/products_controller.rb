# frozen_string_literal: true

class Api::V1::Admin::ProductsController < Api::V1::Admin::BaseController
  def index
    products = Product.includes(:variants)
                      .order(params[:sort_by])
                      .page(params[:page])
                      .per(params[:page_size])
    render json: {
      products: products.as_json,
      record_count: products.size
    }
  end

  def create
    product = Product.new(formatted_params)
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

    if product.update_attributes(formatted_params)
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

  def formatted_params
    cloned_params = product_params.deep_dup
    %w(product_keywords meta_keywords).each do |key|
      cloned_params[key] = cloned_params[key].split(', ')
    end
    cloned_params
  end

  def product_params
    params.require(:product).permit(:name, :description, :category_id,
                                    :permalink, :available_at, :deleted_at,
                                    :meta_keywords, :meta_description, :brand_id, :product_keywords)
  end
end
