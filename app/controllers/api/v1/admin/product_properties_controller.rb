# frozen_string_literal: true

class Api::V1::Admin::ProductPropertiesController < Api::V1::Admin::BaseController
  def index
    product_properties = ProductProperty.with_product_id(params[:product_id]).all

    render json: product_properties.map { |p| ProductPropertySerializer.new(p).as_json }
  end

  def update_from_product
    product = Product.find(params[:product_id])

    if product.nil?
      head :unprocessable_entity
      return
    end

    authorize! :edit, Product
    product.product_properties_attributes = formatted_params[:product_properties_attributes]
    if product.save
      head :ok
    else
      render json: { error_message: product.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def formatted_params
    cloned_params = filtered_params.clone
    cloned_params[:product_properties_attributes].reject! { |pp| pp['value'].blank? || pp['property_id'].blank? }
    cloned_params
  end

  def filtered_params
    params.permit(:product_id, product_properties_attributes: %i[id value position property_id])
  end
end
