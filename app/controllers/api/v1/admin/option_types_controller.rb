class Api::V1::Admin::OptionTypesController < Api::V1::Admin::BaseController
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

  params.require(:option_type).permit(:name, :display_name, :position)
end