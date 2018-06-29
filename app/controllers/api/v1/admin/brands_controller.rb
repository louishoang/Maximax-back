class Api::V1::Admin::BrandsController < Api::V1::Admin::BaseController
  def index
    brands = Brand.all
    render json: brands
  end

  def create
    brand = Brand.new(brand_params)
    authorize! :create, :brand

    if brand.save
      head :created
    else
      render json: {
          error_message: brand.errors.full_messages.join('/n')
      }, status: :unprocessable_entity
    end
  end

  def update
    brand = Brand.find(params[:id])
    authorize! :update, :brand

    if brand.update_attributes(brand_params)
      head :ok
    else
      render json: {
          error_message: brand.errors.full_messages.join('/n')
      }, status: :unprocessable_entity
    end
  end

  private

  def brand_params
    params.permit(:brand).only(:name)
  end
end