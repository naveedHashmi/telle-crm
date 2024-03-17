# frozen_string_literal: true

class EmailsController < BaseController
  before_action :set_client, only: %i[show]

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:client_id])
  end
end
