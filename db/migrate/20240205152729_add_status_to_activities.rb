# frozen_string_literal: true

class AddStatusToActivities < ActiveRecord::Migration[7.0]
  def up
    add_column :activities, :status, :integer, default: 0, null: false
    execute <<-SQL
      ALTER TABLE activities
      ADD CONSTRAINT check_status
      CHECK (status IN (0, 1));
    SQL
  end

  def down
    remove_column :activities, :status, :integer, default: 0, null: false
  end
end
