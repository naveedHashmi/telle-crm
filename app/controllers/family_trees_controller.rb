# frozen_string_literal: true

class FamilyTreesController < BaseController
  before_action :client

  def create
    family_tree = @client.build_family_tree(family_tree_params)

    return unless family_tree.save

    redirect_to client_path(session[:client_id], partial: 'client_family_tree')
  end

  private

  def client
    @client = Client.find(params[:client_id])
  end

  def family_tree_params
    params.require(:family_tree).permit(tree_node_attributes: {})
  end
end
