class DocusignService
  include ApiCreator

  def initialize(current_user, document)
    @client = OAuth2::Client.new('22a58abb-ef2e-404c-9824-ff7ee13bb7a2', 'c032dd4b-5c03-4030-9b7c-e8a21301a107',
                                 site: 'https://account-d.docusign.com', authorize_url: '/oauth/auth', response_type: 'code', scope: 'signature')
    @base_uri = 'https://demo.docusign.net'
    @app_account_id = 'be327cfd-7d1d-485d-b753-7894aef81c5d'
    @current_user = current_user
    @document = document
  end

  def auth_url
    @auth_url = @client.auth_code.authorize_url(redirect_uri: 'http://localhost:3000/docusign/success')
  end

  def make_template_req
    base64_file_content = Base64.encode64(@document.file.open { |file| file.read })
    document = DocuSign_eSign::Document.new({
                                              # Create the DocuSign document object
                                              'documentBase64' => base64_file_content,
                                              'name' => @document.name, # Can be different from actual file name
                                              'fileExtension' => 'pdf', # Many different document types are accepted
                                              'documentId' => '1' # A label used to reference the doc
                                            })

    signer = DocuSign_eSign::Signer.new({
                                          'roleName' => 'signer', 'recipientId' => '1', 'routingOrder' => '1'
                                        })

    signer.tabs = DocuSign_eSign::Tabs.new(
      'signHereTabs' => [],
      'checkboxTabs' => [],
      'listTabs' => [],
      'numericalTabs' => [],
      'radioGroupTabs' => [],
      'textTabs' => []
    )
    # Create top two objects
    envelope_template_definition = DocuSign_eSign::EnvelopeTemplate.new(
      'description' => @document.name,
      'shared' => 'false'
    )

    # Top object:
    DocuSign_eSign::EnvelopeTemplate.new(
      'documents' => [document],
      'name' => @document.name,
      'emailSubject' => 'Please sign this document',
      'envelopeTemplateDefinition' => envelope_template_definition,
      'recipients' => DocuSign_eSign::Recipients.new(
        'signers' => [signer], 'carbonCopies' => []
      ),
      'status' => 'created'
    )
  end

  def create_template
    templates_api = create_template_api({ account_id: @app_account_id, base_path: @base_uri,
                                          access_token: @current_user.docusign_credentials['access_token'] })

    template_req_object = make_template_req
    result = templates_api.create_template(@app_account_id, template_req_object)

    view_request = DocuSign_eSign::ReturnUrlRequest.new({ returnUrl: "http://localhost:3000//clients/#{@document.client_id}/documents/#{@document.id}/update_envelope_id" })
    edit_view = templates_api.create_edit_view(@app_account_id, result.template_id, view_request)

    edit_view.url
  end
end
