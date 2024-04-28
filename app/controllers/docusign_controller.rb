class DocusignController < ApplicationController
  def authenticate
    client = OAuth2::Client.new('22a58abb-ef2e-404c-9824-ff7ee13bb7a2', 'c032dd4b-5c03-4030-9b7c-e8a21301a107',
                                site: 'https://account-d.docusign.com', authorize_url: '/oauth/auth', response_type: 'code', scope: 'signature')

    @auth_url = client.auth_code.authorize_url(redirect_uri: 'http://localhost:3000/docusign/success')
  end

  def success
    client = OAuth2::Client.new('22a58abb-ef2e-404c-9824-ff7ee13bb7a2', 'c032dd4b-5c03-4030-9b7c-e8a21301a107',
                                site: 'https://account-d.docusign.com', authorize_url: '/oauth/auth/', response_type: 'code', scope: 'signature')

    access = client.auth_code.get_token(params[:code])
    access_token = access.token
    refresh_token = access.refresh_token
    expires_in = access.expires_in
    expires_at = access.expires_at

    current_user.update(docusign_credentials: { access_token:, refresh_token:,
                                                expires_in:, expires_at: })
    redirect_to client_path(session[:client_id], partial: 'client_documents')
  end

  def callback
    redirect_to docusign_token_path
  end

  def token
    # byebug
  end
end
