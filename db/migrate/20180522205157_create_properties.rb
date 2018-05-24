# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.string :identifying_name, null: false
      t.string :display_name, null: false
      t.boolean :active, default: true
    end
  end
end
