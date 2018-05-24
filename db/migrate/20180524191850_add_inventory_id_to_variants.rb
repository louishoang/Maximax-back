# frozen_string_literal: true

class AddInventoryIdToVariants < ActiveRecord::Migration[5.2]
  def up
    add_column :variants, :inventory_id, :integer
    add_index :variants, :inventory_id
  end

  def down
    remove_index :variants, :inventory_id
    remove_column :variants, :inventory_id
  end
end
