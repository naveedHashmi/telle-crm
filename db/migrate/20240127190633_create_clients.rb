# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :phone, default: '', null: false
      t.decimal :amount_owed, default: 0, null: false
      t.string :address, default: '', null: false

      t.timestamps
    end
  end
end
