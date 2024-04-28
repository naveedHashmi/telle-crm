# frozen_string_literal: true

class DocumentsController < BaseController
  before_action :client
  before_action :document

  def new
    @document = @client.documents.new
  end

  def create
    document = @client.documents.create(document_params)

    service = DocusignService.new(current_user, document)

    redirect_to service.create_template, allow_other_host: true
  end

  def update_template_id
    document = Document.find_by(id: params[:id])

    document&.update(docusign_template_id: params[:docusign_template_id])

    redirect_to client_path(session[:client_id], partial: 'client_documents')
  end

  def configure
    service = DocusignService.new(current_user, @document)

    redirect_to service.configure_url, allow_other_host: true
  end

  def sign
    service = DocusignService.new(current_user, @document)
    service.signature_request
  end

  private

  def client
    @client ||= Client.find_by(id: params[:client_id])
  end

  def document_params
    params.require(:document).permit(:name, :file)
  end

  def document
    @document ||= Document.find_by(id: params[:id])
  end
end
