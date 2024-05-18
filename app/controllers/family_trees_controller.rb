# frozen_string_literal: true

class FamilyTreesController < BaseController
  before_action :client

  def index
    family_tree = @client.family_tree

    tree_node = family_tree.tree_node

    render json: create_tree(tree_node, []), success: true
  end

  def create
    family_tree = @client.build_family_tree(family_tree_params)

    nil unless family_tree.save
  end

  private

  def client
    @client = Client.find(params[:client_id])
  end

  def family_tree_params
    params.require(:family_tree).permit(tree_node_attributes: {})
  end

  def create_tree(tree_node, arr)
    if tree_node.child_nodes.present?
      tree_node.child_nodes.all.each do |child_node|
        create_tree(child_node, arr)
      end
    end

    arr << [tree_node.person_name, tree_node.title, tree_node.status, tree_node.id.to_s,
            tree_node.parent_node_type == 'FamilyTree' ? '' : tree_node.parent_node_id.to_s]

    arr
  end
end
