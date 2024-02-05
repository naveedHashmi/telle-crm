# frozen_string_literal: true

class ChangeUserableToNullableInUsers < ActiveRecord::Migration[7.0]
  def up
    change_column :users, :userable_id, :integer, null: true
    change_column :users, :userable_type, :string, null: true
  end

  def down
    # change_column :users, :userable_id, :integer, null: false
    # change_column :users, :userable_type, :string, null: false
  end
end
