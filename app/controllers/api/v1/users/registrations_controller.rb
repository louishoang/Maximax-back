# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    @user = build_resource(sign_up_params)
    @user.save

    if @user.persisted?
      if @user.active_for_authentication?
        sign_up(:user, @user)

        render json: @user.as_json(
            auth_token: user.authentication_token,
            email: user.email
        ), status: :created
      else
        # User signed up but inactive
        expire_data_after_sign_in!
        render json: {
            message: translate('devise.confirmations.send_instructions')
        }, status: :ok
      end

    else
      warden.custom_failure!
      message = @user.errors.full_messages.join('\n')
      render json: {
          error_message: messages
      }, status: :bad_request
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  #

  def resource_name
    :user
  end
end
