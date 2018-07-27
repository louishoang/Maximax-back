# frozen_string_literal: true

class Variant < ApplicationRecord
  before_save :ensure_one_master
  after_destroy :reassign_master

  belongs_to :product
  belongs_to :inventory, optional: true
  has_many :option_value_variants
  has_many :option_values, through: :option_value_variants
  has_many :cart_items

  accepts_nested_attributes_for :inventory, allow_destroy: true

  validates :price,       presence: true
  validates :cost,        presence: true
  validates :product_id,  presence: true
  validates :sku,         presence: true, length: { maximum: 255 }
  validates :sku, uniqueness: { scope: :product_id }

  delegate  :brand, to: :product, allow_nil: true
  delegate :count_on_hand, to: :inventory, allow_nil: true
  scope :master, -> { where(master: true) }

  private

  def ensure_one_master
    if master
      product.variants.where.not(id: id).update_all(master: false)
    elsif product.variants.size.zero?
      self.master = true
    else
      product.variants.first.update_column(:master, true)
    end
  end

  def reassign_master
    product.variants.first.update_column(:master, true)
  end
end
