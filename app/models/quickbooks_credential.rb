class QuickbooksCredential < ApplicationRecord
  belongs_to :user

  validates_presence_of :access_token, :access_token_expires_at, :refresh_token, :refresh_token_expires_at, :realm_id
end
