# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.integer :product_id, null: false
      t.string :sku, null: false, unique: true
      t.string :name
      t.decimal :price, precision: 8, scale: 2, default: 0.0, null: false
      t.decimal :cost, precision: 8, scale: 2, default: 0.0, null: false
      t.datetime :deleted_at
      t.boolean :master, default: false, null: false
      t.timestamps
    end

    add_index :variants, :sku
    add_index :variants, :product_id
  end
end
