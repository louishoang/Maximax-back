class Api::V1::Admin::CategoriesController < Api::V1::Admin::BaseController
  def index
    categories = Category.all
    render json: categories.as_json
  end
end