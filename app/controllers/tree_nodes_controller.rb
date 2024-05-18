# frozen_string_literal: true

class TreeNodesController < BaseController
  before_action :set_parent_node

  def childs
    tree_node = @parent_node.child_nodes.new(tree_node_params)

    return unless tree_node.save

    redirect_to client_path(session[:client_id], partial: 'client_family_tree')
  end

  private

  def set_parent_node
    @parent_node = TreeNode.find(params[:id])
  end

  def tree_node_params
    params.require(:tree_node).permit(:person_name, :title, :status)
  end
end
