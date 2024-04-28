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
      'emailSubject' => @document.name,
      'envelopeTemplateDefinition' => envelope_template_definition,
      'recipients' => DocuSign_eSign::Recipients.new(
        'signers' => [signer], 'carbonCopies' => []
      ),
      'status' => 'created'
    )
  end

  def create_template
    template_req_object = make_template_req
    result = templates_api.create_template(@app_account_id, template_req_object)

    @document.update(docusign_template_id: result.template_id)

    configure_url
  end

  def templates_api
    @templates_api ||= create_template_api({ account_id: @app_account_id, base_path: @base_uri,
                                             access_token: @current_user.docusign_credentials['access_token'] })
  end

  def configure_url
    template_id = @document.docusign_template_id
    view_request = DocuSign_eSign::ReturnUrlRequest.new({ returnUrl: "http://localhost:3000//clients/#{@document.client_id}/documents/#{@document.id}/update_template_id?docusign_template_id=#{template_id}" })
    edit_view = templates_api.create_edit_view(@app_account_id, template_id, view_request)

    edit_view.url
  end

  def signature_request
    template_id = @document.docusign_template_id
    client = Client.find(@document.client_id)

    return unless template_id

    begin
      envelope_args = {
        signer_email: client.email,
        signer_name: client.name,
        # cc_email: params['ccEmail'],
        # cc_name: params['ccName'],
        template_id:
      }

      args = {
        account_id: @app_account_id,
        base_path: @base_uri,
        access_token: @current_user.docusign_credentials['access_token'],
        envelope_args:
      }

      results = UseTemplateService.new(args).worker
      envelope_id = results[:envelope_id]

      # Create the sender view
      view_request = DocuSign_eSign::ReturnUrlRequest.new({ returnUrl: 'http://localhost:3000/docusign/success' })
      envelope_api = create_envelope_api(args)
      results = envelope_api.create_sender_view args[:account_id], envelope_id, view_request
      # Switch to the Recipients/Documents view if requested by the user in the form
      url = results.url
      url = url.sub! 'send=1', 'send=0' if args[:starting_view] == 'recipient'

      { 'envelope_id' => envelope_id, 'redirect_url' => url }
    rescue DocuSign_eSign::ApiError => e
      puts e
    end
  end
end
