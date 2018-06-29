# frozen_string_literal: true

class OptionValue < ApplicationRecord
  belongs_to :option_type, inverse_of: :option_values

  with_options presence: true do
    validates :name, uniqueness: { scope: :option_type_id }
    validates :presentation
  end
end
