# frozen_string_literal: true

class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :role, :integer, default: 0
    add_index :users, :role
  end

  def down
    remove_index :users, :role
    remove_column :users, :role
  end
end
