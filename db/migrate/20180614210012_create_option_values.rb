# frozen_string_literal: true

class CreateOptionValues < ActiveRecord::Migration[5.2]
  def change
    create_table :option_values do |t|
      t.string :name, limit: 100
      t.string :display_name, limit: 100
      t.integer :position, default: 1, null: false
      t.integer :option_type_id, null: false
      t.timestamps
    end

    add_index :option_values, %i[name display_name]
    add_index :option_values, :option_type_id
    add_index :option_values, :position
  end
end
