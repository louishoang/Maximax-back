# frozen_string_literal: true

class Api::V1::Admin::VariantsController < Api::V1::Admin::BaseController
  def index; end

  def create
    variant = Variant.new(variant_params)
    authorize! :create, Variant

    if variant.save
      head :created
    else
      render json: variant.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  def update
    variant = Variant.find(params[:id])
    authorize! :update, Variant

    if variant.update(variant_params)
      head :ok
    else
      render json: { error_message: variant.errors.full_messages.join(', ') },
             status: :unprocessable_entity
    end
  end

  def destroy
    variant = Variant.find(params[:id])
    authorize! :destroy, Variant

    if variant.destroy
      head :ok
    else
      render json: variant.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  private

  def variant_params
    params.require(:variant).permit(:id, :name, :sku, :cost, :price, :deleted_at,
                                    :inventory_id, :product_id, :master,
                                    option_value_ids: [],
                                    inventory_attributes: %i[vendor_link count_on_hand sku vendor_sku])
  end
end
