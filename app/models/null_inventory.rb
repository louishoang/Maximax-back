# frozen_string_literal: true

class NullInventory
  def sku
    ''
  end

  alias vendor_sku sku

  def vendor_link
    'http://'
  end

  def count_on_hand
    0
  end
end
