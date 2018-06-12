# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: :destroy
  before_action :verify_signed_in_user, only: :destroy

  # POST /resource/sign_in
  def create
    user = User.where(email: sign_in_params[:email]).first

    if login_succeed? user
      # TODO: use active record serilizer to format expire_at
      auth_token_expired_at = user.auth_token_expired_at.iso8601
      render json: {
        user: user.as_json(only: %i[email authentication_token first_name last_name])
                  .merge(auth_token_expired_at: auth_token_expired_at),
        message: translate('devise.sessions.signed_in')
      }, status: :ok
    else
      error_message = if user && !user.confirmed?
                        translate('devise.registrations.signed_up_but_inactive')
                      else
                        translate('devise.failure.invalid', authentication_keys: 'email')
                      end
      render json: { error_message: error_message }, status: :unauthorized
    end
  end

  # DELETE /resource/sign_out
  def destroy
    user = User.where(email: request.headers['X-User-Email']).first
    user.update_attribute(:authentication_token, nil)
    render json: {
      message: translate('devise.sessions.signed_out')
    }, status: :ok
  end

  private

  # Devise use this method to indentify the correct resource Api::V1::User instead of User
  def resource_name
    :user
  end

  def login_succeed?(user)
    return false unless user&.confirmed? && user&.valid_password?(sign_in_params[:password])

    user.last_sign_in_at = DateTime.now
    user.save
  end

  def verify_signed_in_user
    token = request.headers['X-User-Token']
    email = request.headers['X-User-Email']

    fail_request unless token.present? && email.present?

    user = User.where(email: email).first
    return head :ok if user&.auth_token_expired?

    # https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    fail_request unless user.present? &&
                        Devise.secure_compare(user.authentication_token, token)
  end

  def fail_request
    head :unprocessable_entity
  end
end
