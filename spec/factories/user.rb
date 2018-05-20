FactoryBot.define do
  factory :user do
    email Faker::Internet.email
    password '123456789'
    password_confirmation '123456789'
    authentication_token SecureRandom.urlsafe_base64(16)
    auth_token_issued_at DateTime.now
  end
end
