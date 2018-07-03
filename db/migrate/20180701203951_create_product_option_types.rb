# frozen_string_literal: true

class CreateProductOptionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_option_types do |t|
      t.integer :position
      t.integer :product_id
      t.integer :option_type_id
      t.timestamps
    end

    add_index :product_option_types, :product_id
    add_index :product_option_types, :position
    add_index :product_option_types, :option_type_id
  end
end
