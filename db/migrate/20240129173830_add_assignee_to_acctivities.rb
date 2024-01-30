class AddAssigneeToAcctivities < ActiveRecord::Migration[7.0]
  def change
    Activity.destroy_all
    add_reference :activities, :assignee, polymorphic: true, null: false
    remove_reference :activities, :client, index: true, foreign_key: true
  end
end
