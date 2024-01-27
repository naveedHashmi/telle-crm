# frozen_string_literal: true

class AddUserableToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :userable, polymorphic: true, null: false
  end
end
