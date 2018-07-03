# frozen_string_literal: true

class CreateOptionValueVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :option_value_variants do |t|
      t.integer :variant_id
      t.integer :option_value_id
    end

    add_index :option_value_variants, :option_value_id
    add_index :option_value_variants, %i[variant_id option_value_id]
  end
end
