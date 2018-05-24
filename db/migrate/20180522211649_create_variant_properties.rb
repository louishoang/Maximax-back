# frozen_string_literal: true

class CreateVariantProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :variant_properties do |t|
      t.integer :variant_id, null: false
      t.integer :property_id, null: false
      t.string :description, null: false
      t.boolean :primary, default: false
    end

    add_index :variant_properties, :variant_id
    add_index :variant_properties, :property_id
  end
end
