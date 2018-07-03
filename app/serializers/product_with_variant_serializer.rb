# frozen_string_literal: true

class ProductWithVariantSerializer < ProductSerializer
  has_many :variants
end
