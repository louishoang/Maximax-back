# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  before_action :authenticate_api_v1_user!
end
