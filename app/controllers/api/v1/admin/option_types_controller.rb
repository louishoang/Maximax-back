# frozen_string_literal: true

class Api::V1::Admin::OptionTypesController < Api::V1::Admin::BaseController
  def index
    option_types = OptionType.includes(:option_values).all
    render json: option_types
  end

  def show
    option_type = OptionType.find(params[:id])
    render json: option_type
  end

  def update
    option_type = OptionType.find(params[:id])
    authorize! :update, :option_type

    if option_type.update_attributes(formatted_params)
      head :ok
    else
      render json: {
        error_message: option_type.errors.full_messages.join('\n')
      }, status: :bad_request
    end
  end

  def create
    authorize! :create, :OptionType
    @option_type = OptionType.new(option_type_params)
    if @option_type.save
      head :created
    else
      render json: {
        error_message: @option_type.errors.full_messages.join('\n')
      }, status: :bad_request
    end
  end

  private

  def formatted_params
    clone = option_type_params.clone
    valid_option_values = clone[:option_values].select { |item| OptionValue.valid_record?(item) }
    clone[:option_values_attributes] = valid_option_values
    clone.delete(:option_values)
    clone
  end

  def option_type_params
    params.require(:option_type).permit(:name, :display_name, :position,
                                        option_values: %i[id name display_name position])
  end
end
