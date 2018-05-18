# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: :create
  prepend_before_action :allow_params_authentication!, only: :create
  # before_action :configure_sign_in_params, only: [:create]

  # POST /resource/sign_in
  def create
    user = User.where(email: params[:user][:email]).first

    if user && user.valid_password?(params[:user][:password])
      render json: user.as_json(only: [:email]), status: :ok
    else
      head :unauthorized
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message! :notice, :signed_out if signed_out
  #   yield if block_given?
  #   respond_to_on_destroy
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
