class AddIndexClientIdOnDeals < ActiveRecord::Migration[7.0]
  def up
    Deal.destroy_all
    remove_index :deals, :client_id
    add_index :deals, :client_id, unique: true
  end

  def down
    add_index :deals, :client_id
  end
end
