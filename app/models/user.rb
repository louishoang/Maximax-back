class User < ApplicationRecord
  acts_as_token_authenticatable

  before_save :ensure_auth_token_issued_at

  DEFAULT_AUTH_TOKEN_REFRESH_CYCLE = 2.weeks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  def auth_token_expired_at
    auth_token_issued_at + 2.weeks
  end

  def auth_token_expired?
    auth_token_expired_at <= DateTime.now
  end

  private

  def ensure_auth_token_issued_at
    if authentication_token.blank? || authentication_token_changed?
      self.auth_token_issued_at = DateTime.now
    end
  end
end