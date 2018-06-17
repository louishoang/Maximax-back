# frozen_string_literal: true

class Api::V1::Admin::BaseController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :verify_admin

  alias current_user current_api_v1_user

  private

  def verify_admin
    head :forbidden unless current_api_v1_user&.admin_accessible?
  end
end
