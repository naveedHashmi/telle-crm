class GmailController < ApplicationController
  def authenticate
    client = Signet::OAuth2::Client.new({
                                          client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
                                          client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
                                          authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
                                          scope: Google::Apis::GmailV1::AUTH_GMAIL_READONLY,
                                          redirect_uri: "#{ENV.fetch('BASE_URL')}/auth/success",
                                          access_type: 'offline'
                                        })

    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  def success
    client = Signet::OAuth2::Client.new({
                                          client_id: ENV.fetch('GOOGLE_API_CLIENT_ID'),
                                          client_secret: ENV.fetch('GOOGLE_API_CLIENT_SECRET'),
                                          token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
                                          redirect_uri: "#{ENV.fetch('BASE_URL')}/auth/success",
                                          code: params[:code]
                                        })

    response = client.fetch_access_token!
    current_user.update(gmail_credentials: response)
    redirect_to client_path(session[:client_id], partial: 'client_emails')
  end
end
