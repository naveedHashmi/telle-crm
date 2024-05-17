class TreeNode < ApplicationRecord
  belongs_to :parent_node, polymorphic: true

  has_many :child_nodes, -> { where(parent_node_type: 'TreeNode') }, class_name: 'TreeNode', foreign_key: 'parent_node_id', dependent: :destroy
end
