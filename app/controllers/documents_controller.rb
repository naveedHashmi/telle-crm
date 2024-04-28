# frozen_string_literal: true

class DocumentsController < BaseController
  before_action :client

  def new
    @document = @client.documents.new
  end

  def create
    document = @client.documents.create(document_params)

    service = DocusignService.new(current_user, document)

    redirect_to service.create_template, allow_other_host: true
  end

  def update_envelope_id
    document = Document.find_by(id: params[:id])

    document&.update(docusign_envelope_id: params[:envelopeId])

    redirect_to client_path(session[:client_id], partial: 'client_documents')
  end

  private

  def client
    @client ||= Client.find_by(id: params[:client_id])
  end

  def document_params
    params.require(:document).permit(:name, :file)
  end
end
