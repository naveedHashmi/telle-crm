# frozen_string_literal: true

class AddGmailCredentialsForUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gmail_credentials, :jsonb, default: {}, nil: false
  end
end
