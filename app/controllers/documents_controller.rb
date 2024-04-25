# frozen_string_literal: true

class DocumentsController < BaseController
  before_action :client

  def new
    @document = @client.documents.new
  end

  def create
    @client.documents.create(document_params)
  end

  private

  def client
    @client ||= Client.find_by(id: params[:client_id])
  end

  def document_params
    params.require(:document).permit(:name, :file)
  end
end