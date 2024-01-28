# frozen_string_literal: true

class AddClaimNoToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :claim_no, :string, default: '', null: false
  end
end
