class CreateFamilyTrees < ActiveRecord::Migration[7.0]
  def up
    create_table :family_trees do |t|
      t.references :family_treeable, polymorphic: true, null: false
      t.timestamps
    end
    remove_index :family_trees, name: 'index_family_trees_on_family_treeable'
    add_index :family_trees, %i[family_treeable_type family_treeable_id], unique: true,
                                                                          name: 'index_family_trees_on_family_treeable'
  end

  def down
    remove_index :family_trees, name: 'index_family_trees_on_family_treeable'
    drop_table :family_trees
  end
end
