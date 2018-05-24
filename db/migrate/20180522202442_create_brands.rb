# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name, null: false
    end
  end
end
