class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.integer :product_id, null: false
      t.integer :position, default: 0, null: false
      t.timestamps
    end

    add_index :product_images, :product_id
    add_index :product_images, :position
  end
end
