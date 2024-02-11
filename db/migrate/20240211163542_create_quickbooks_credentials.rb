class CreateQuickbooksCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :quickbooks_credentials do |t|
      t.text :access_token, null: false
      t.datetime :access_token_expires_at, null: false
      t.text :refresh_token, null: false
      t.datetime :refresh_token_expires_at, null: false
      t.text :realm_id, null: false
      t.references :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
