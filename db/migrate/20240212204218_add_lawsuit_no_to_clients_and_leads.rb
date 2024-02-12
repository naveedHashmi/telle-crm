# frozen_string_literal: true

class AddLawsuitNoToClientsAndLeads < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :lawsuit_no, :string, default: '', null: false
    add_column :leads, :lawsuit_no, :string, default: '', null: false
  end
end
