class AddObjectChangesColumnToVersions < ActiveRecord::Migration[7.0]
  def change
    add_column :versions, :object_changes, :text, default: ''
  end
end
