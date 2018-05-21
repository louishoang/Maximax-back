# frozen_string_literal: true

class AddTokenIssuedAtToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :auth_token_issued_at, :datetime
  end

  def down
    remove_column :users, :auth_token_issued_at
  end
end
