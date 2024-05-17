class CreateTreeNodes < ActiveRecord::Migration[7.0]
  def up
    create_table :tree_nodes do |t|
      t.references :parent_node, polymorphic: true, null: false
      t.string :person_name, default: '', null: false
      t.string :title, default: '', null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    remove_index :tree_nodes, name: 'index_tree_nodes_on_parent_node'
    add_index :tree_nodes, %i[parent_node_type parent_node_id], unique: true, name: 'index_tree_nodes_on_parent_node',
                                                                where: "parent_node_type='FamilyTree'"
  end

  def down
    remove_index :tree_nodes, name: 'index_tree_nodes_on_parent_node'
    drop_table :tree_nodes
  end
end
