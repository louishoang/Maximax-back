class Api::V1::CartsController < Api::V1::BaseController
  def update
    cart = Cart.find_by_id(params[:id])

    if cart.update_attributes(cart_params)
      render json: {
        cart: cart
      }
    else
      render json: {
        error_message: cart.errors.full_messages.join('/n')
      }, status: :unprocessable_entity
    end
  end

  def find_cart_by_user
    cart = Cart.find_or_create_by(user_id: params[:user_id], cart_type: :shopping_cart)
    cart.filter_inactive_items

    if cart
      render json: cart
    else
      head :unprocessable_entity
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:id, cart_items_attributes: %i[id variant_id quantity])
  end
end