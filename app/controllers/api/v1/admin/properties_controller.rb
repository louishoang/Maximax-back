# frozen_string_literal: true

class Api::V1::Admin::PropertiesController < Api::V1::Admin::BaseController
  def index
    properties = Property.all
    render json: properties
  end

  def create
    property = Property.new(property_params)
    authorize! :create, Property

    if property.save
      head :ok
    else
      render json: { error_message: property.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    property = Property.find(params[:id])
    authorize! :destroy, Property
    if property.destroy
      head :ok
    else
      render json: { error_message: property.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def property_params
    params.require(:property).permit(:id, :identifying_name, :display_name, :active)
  end
end
