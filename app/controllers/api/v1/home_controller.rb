# frozen_string_literal: true

class Api::V1::HomeController < Api::V1::BaseController
  skip_before_action :authenticate_api_v1_user!

  MIN_NEW_ARRIVAL_PRODUCTS = 18

  def index
    products = {
      best_seller: random(10),
      trending_now: random(10),
      hot_deals: random(30)
    }

    render json: products
  end

  def new_arrivals
    category_ids = (Category.find_by_name(params[:category_name]).descendents.pluck(:id) if params[:category_name].present?)
    products = Product.includes(product_images: [file_attachment: [:blob]])
                      .order(params[:sort_by])
                      .with_category_ids(category_ids)
                      .page(params[:page])
                      .per(params[:page_size])

    products = serializer_list(products) + random(MIN_NEW_ARRIVAL_PRODUCTS - products.size) if products.size < MIN_NEW_ARRIVAL_PRODUCTS

    render json: products
  end

  def random(num)
    list = Product.where(id: Product.pluck(:id).sample(num))
    serializer_list(list)
  end

  def serializer_list(list)
    list.map { |p| SimpleProductSerializer.new(p).as_json }
  end
end
