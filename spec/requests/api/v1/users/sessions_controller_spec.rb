# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users::SessionsController', type: :request do
  !let(:user) { FactoryBot.create(:user) }

  context 'POST #create' do
    context 'when user exists and confirmed' do
      before do
        user.confirm
        post '/api/v1/users/sign_in', params: { user: { email: user.email, password: user.password } }
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an email' do
        expect(parsed_response[:user]).to include(email: user.email)
      end

      it 'returns an auth token' do
        expect(parsed_response[:user]).to include(authentication_token: user.authentication_token)
      end

      it "returns auth token's expiration_date" do
        expect(parsed_response[:user]).to include(auth_token_expired_at: user.auth_token_expired_at)
      end

      it 'returns a login successfully message' do
        expect(parsed_response).to include(message: I18n.t('devise.sessions.signed_in'))
      end
    end

    context 'when user exists but NOT confirmed yet' do
      before do
        post '/api/v1/users/sign_in', params: { user: { email: user.email, password: user.password } }
      end

      it 'returns 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error_message' do
        expect(parsed_response).to include(error_message: I18n.t('devise.registrations.signed_up_but_inactive'))
      end
    end

    context "when user doesn't exist" do
      let(:not_existed_user) { FactoryBot.build(:user) }

      before do
        post '/api/v1/users/sign_in', params: { user: { email: not_existed_user.email, password: not_existed_user.password } }
      end

      it 'returns 401' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error_message' do
        expect(parsed_response).to include(error_message: I18n.t('devise.failure.invalid', authentication_keys: 'email'))
      end
    end

    context 'when email not provided' do
      it 'returns 401' do
        post '/api/v1/users/sign_in', params: { user: { password: user.password } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when password not provided' do
      it 'returns 401' do
        post '/api/v1/users/sign_in', params: { user: { email: user.email } }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when wrong password' do
      it 'returns 401' do
        post '/api/v1/users/sign_in', params: { user: { email: user.email, password: 'something_wrong' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context '#sign_out' do
    context 'a logged in user try to log out' do
      before { user.confirm }
      let(:token) { user.authentication_token }

      before do
        delete '/api/v1/users/sign_out', headers: { 'X-User-Token' => token, 'X-User-Email' => user.email }
      end

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
