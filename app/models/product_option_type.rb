# frozen_string_literal: true

class ProductOptionType < ApplicationRecord
  belongs_to :product, inverse_of: :product_option_types
  belongs_to :option_type, inverse_of: :product_option_types

  # validates :product_id, :option_type_id, presence: true
  # validates :product_id, uniqueness: { scope: :option_type_id }, allow_nil: true
end
