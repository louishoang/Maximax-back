# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :first_name, :string, length: 40
    add_column :users, :last_name, :string, length: 40

    add_index :users, :first_name
    add_index :users, :last_name
  end

  def down
    remove_index :users, :first_name
    remove_index :users, :last_name

    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
