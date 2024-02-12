# frozen_string_literal: true

class AssociateLeadsAndClientsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :user_id, :bigint
    add_column :leads, :user_id, :bigint

    user = User.find_or_create_by(first_name: 'Admin', last_name: 'Chuntelle', email: 'chuntelle@orp.com')

    Client.update_all(user_id: user.id)
    Lead.update_all(user_id: user.id)

    add_foreign_key :clients, :users, column: :user_id, null: false
    add_foreign_key :leads, :users, column: :user_id, null: false
  end
end
