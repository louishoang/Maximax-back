# frozen_string_literal: true

module TestHelpers
  def parsed_response
    JSON.parse(response.body, symbolize_names: true)
  end
end
