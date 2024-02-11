# frozen_string_literal: true

class QuickbooksService
  include Rails.application.routes.url_helpers

  def initialize
    oauth_params = {
      site: 'https://appcenter.intuit.com/connect/oauth2',
      authorize_url: 'https://appcenter.intuit.com/connect/oauth2',
      token_url: 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer'
    }

    @oauth2_client = OAuth2::Client.new(ENV['OAUTH_CLIENT_ID'], ENV['OAUTH_CLIENT_SECRET'], oauth_params)
    @redirect_uri = quickbooks_callback_url
  end

  def get_token(params)
    @oauth2_client.auth_code.get_token(params[:code], redirect_uri: @redirect_uri)
  end

  def authorize_url
    @oauth2_client.auth_code.authorize_url(
      redirect_uri: @redirect_uri,
      response_type: 'code',
      state: SecureRandom.hex(12),
      scope: 'com.intuit.quickbooks.accounting'
    )
  end
end
