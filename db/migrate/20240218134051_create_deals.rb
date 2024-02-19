# frozen_string_literal: true

class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :deals do |t|
      t.string :claim_no, default: 0, null: false
      t.decimal :amount_owed, default: 0, null: false
      t.decimal :fee_percent, default: 0, null: false
      t.integer :status, default: 0, null: false
      t.decimal :expected_commission, default: 0, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
