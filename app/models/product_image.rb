# frozen_string_literal: true

class ProductImage < ApplicationRecord
  belongs_to :product
  has_one_attached :file

  after_create :generate_variants

  default_scope -> { order('position') }

  validates :product_id, presence: true
  validates :position, presence: true

  def thumbnail
    file.variant(combine_options: {
                   background: 'white',
                   gravity: 'center',
                   resize: '100x100',
                   extent: '100x100'
                 }).processed
  end

  def square
    file.variant(combine_options: {
                   background: 'white',
                   gravity: 'center',
                   resize: '400x400',
                   extent: '400x400'
                 }).processed
  end

  private

  def generate_variants
    square
    thumbnail
  end
end
