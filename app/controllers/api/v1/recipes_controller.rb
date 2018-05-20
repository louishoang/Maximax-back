# frozen_string_literal: true

class Api::V1::RecipesController < Api::V1::BaseController
  def index
    render json: { data: 'worked' }
  end
end
