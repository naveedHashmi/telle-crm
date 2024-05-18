class TreeNode < ApplicationRecord
  belongs_to :parent_node, polymorphic: true

  enum status: {diseased: 0, alive: 1}

  has_many :child_nodes, -> { where(parent_node_type: 'TreeNode') }, class_name: 'TreeNode', foreign_key: 'parent_node_id', dependent: :destroy
end
