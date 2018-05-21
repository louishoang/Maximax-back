# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users::RegistrationsController', type: :request do
  context '#create' do
    let(:user_params) do
      {
        email: user.email,
        password: user.password,
        password_confirmation: user.password
      }
    end

    context 'New account' do
      !let(:user) { FactoryBot.build(:user) }

      context 'Successful but need activation' do
        before do
          post '/api/v1/users', params: { user: user_params }
        end

        it 'returns code 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns a message' do
          expect(parsed_response).to include(message: I18n.t('devise.confirmations.send_instructions'))
        end
      end

      %i[email password].each do |key|
        context "When param #{key} is missing" do
          before { user_params.delete(key) }

          it 'returns 400 error' do
            post '/api/v1/users', params: { user: user_params }
            expect(response).to have_http_status(400)
          end
        end
      end
    end

    context 'Information duplicated' do
      !let(:user) { FactoryBot.create(:user) }

      before do
        post '/api/v1/users', params: { user: user_params }
      end

      it 'returns code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns an error message' do
        expect(parsed_response).to include(error_message: 'Email has already been taken')
      end
    end
  end
end
