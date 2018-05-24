# frozen_string_literal: true

class Brand < ApplicationRecord
  has_many :products

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
