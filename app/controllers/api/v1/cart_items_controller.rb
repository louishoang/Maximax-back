# frozen_string_literal: true

class Api::V1::CartItemsController < Api::V1::BaseController
  def create
    cart_item = CartItem.new(cart_item_params)

    if cart_item.save
      head :ok
    else
      render json: {
        error_message: cart_item.errors.full_messages.join('/n')
      }, status: :unprocessable_entity
    end
  end

  def update
    cart_item = CartItem.find(params[:id])

    if cart_item.update(cart_item_params)
      head :ok
    else
      render json: {
        error_message: cart_item.errors.full_messages.join('/n')
      }, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])

    if cart_item.destroy
      head :ok
    else
      render json: {
        error_message: cart_item.errors.full_messages.join('/n')
      }, status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:id, :variant_id, :cart_id, :quantity, :item_type, :active)
  end
end
