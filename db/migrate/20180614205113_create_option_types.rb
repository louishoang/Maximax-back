class CreateOptionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :option_types do |t|
      t.string :name, limit: 100
      t.string :display_name, limit: 100
      t.integer :position, default: 0, null: false
      t.timestamps
    end

    add_index :option_types, :name
  end
end
