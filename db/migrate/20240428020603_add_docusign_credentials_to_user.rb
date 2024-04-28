class AddDocusignCredentialsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :docusign_credentials, :jsonb,
               default: { access_token: '', refresh_token: '', expires_in: 0, expires_at: 0 }
  end
end
