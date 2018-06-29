# frozen_string_literal: true

class ProductImage < ApplicationRecord
  belongs_to :product
  has_one_attached :file

  default_scope -> { order('position') }

  validates :product_id, presence: true
  validates :position, presence: true
end
