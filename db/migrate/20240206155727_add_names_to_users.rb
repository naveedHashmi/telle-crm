# frozen_string_literal: true

class AddNamesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, default: '', null: false
    add_column :users, :last_name, :string, default: '', null: false
    add_column :users, :phone_no, :string, default: '', null: false
  end
end
