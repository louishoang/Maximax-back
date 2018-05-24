# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.text :product_keywords
      t.datetime :available_at
      t.datetime :deleted_at
      t.string :meta_keywords
      t.string :meta_description
      t.integer :category_id, null: false
      t.string :permalink, null: false
      t.integer :brand_id, null: false
      t.timestamps
    end

    add_index :products, :name
    add_index :products, :category_id
    add_index :products, :deleted_at
    add_index :products, :permalink, unique: true
    add_index :products, :brand_id
  end
end
