# frozen_string_literal: true

class AddVendorLinkToInventories < ActiveRecord::Migration[5.2]
  def up
    add_column :inventories, :vendor_link, :text
    add_column :inventories, :sku, :string, limit: 50
    add_index :inventories, :sku
  end

  def down
    remove_column :inventories, :vendor_link
    remove_index :inventories, :sku
    remove_column :inventories, :sku
  end
end
