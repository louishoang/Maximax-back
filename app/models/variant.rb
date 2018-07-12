# frozen_string_literal: true

class Variant < ApplicationRecord
  before_save :ensure_one_master

  belongs_to :product
  belongs_to :inventory, optional: true
  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants

  accepts_nested_attributes_for :inventory, allow_destroy: true

  validates :price,       presence: true
  validates :cost,        presence: true
  validates :product_id,  presence: true
  validates :sku,         presence: true, length: { maximum: 255 }

  delegate  :brand, to: :product, allow_nil: true
  scope :master, -> { where(master: true) }

  private

  def ensure_one_master
    if master
      product.variants.update_all(master: false)
    else
      return unless product.variants.master.blank?
      self.master = true
    end
  end
end
