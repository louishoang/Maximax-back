# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id', optional: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  validates :name, presence: true, length: { maximum: 255 }

  def descendents
    children.map do |child|
      [child] + child.descendents
    end.flatten
  end
end
