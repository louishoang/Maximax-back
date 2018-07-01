# frozen_string_literal: true

class Api::V1::Admin::CategoriesController < Api::V1::Admin::BaseController
  def index
    categories = Category.includes(:parent).all
    render json: categories
  end
end
