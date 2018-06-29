# frozen_string_literal: true

class OptionType < ApplicationRecord
  with_options dependent: :destroy, inverse_of: :option_type do
    has_many :option_values, -> { order(:position) }
    has_many :product_option_types
  end

  has_many :products, through: :product_option_types

  validates :name, uniqueness: true, allow_blank: true
  validates :display_name
end
