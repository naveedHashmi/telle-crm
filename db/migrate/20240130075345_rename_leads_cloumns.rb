# frozen_string_literal: true

class RenameLeadsCloumns < ActiveRecord::Migration[7.0]
  def change
    rename_column :leads, :initial_bit_amount, :initial_bid_amount
    rename_column :leads, :country, :county
  end
end
