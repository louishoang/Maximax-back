# frozen_string_literal: true

class OptionValueVariant < ApplicationRecord
  belongs_to :option_value
  belongs_to :variant

  validates :option_value, :variant, presence: true
  validates :option_value_id, uniqueness: { scope: :variant_id }
end
