# frozen_string_literal: true

class CreateProductProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :product_properties do |t|
      t.integer :product_id, null: false
      t.integer :property_id, null: false
      t.integer :position, default: 0
      t.string :value
      t.timestamps
    end

    add_index :product_properties, %i[product_id property_id]
  end
end
