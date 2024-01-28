# frozen_string_literal: true

class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.integer :status
      t.decimal :amount_owed
      t.string :property_sold
      t.string :country
      t.date :date_sold
      t.string :mortgage_company
      t.decimal :initial_bit_amount
      t.decimal :sold_amount

      t.timestamps
    end
  end
end
