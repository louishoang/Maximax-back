# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  validates :name, presence: true, length: { maximum: 255 }

  def parent_name
    parent_id ? parent.name : ''
  end

  def as_json(*)
    super.except('created_at', 'updated_at').tap do |hash|
      hash['parent_name'] = parent_name
    end
  end
end
