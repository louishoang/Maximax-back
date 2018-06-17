# frozen_string_literal: true

class Property < ApplicationRecord
  has_many :product_properties, dependent: :delete_all, inverse_of: :property
  has_many :product, through: :product_properties

  validates :identifying_name, presence: true, length: { maximum: 250 }
  validates :display_name, presence: true, length: { maximum: 165 }
end
