# frozen_string_literal: true

class Inventory < ApplicationRecord
  has_one :variant

  def quantity_available
    (count_on_hand - count_pending_to_customer)
  end
end
