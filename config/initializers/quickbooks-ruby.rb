oauth_params = {
  site: 'https://appcenter.intuit.com/connect/oauth2',
  authorize_url: 'https://appcenter.intuit.com/connect/oauth2',
  token_url: 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer',
  redirect_url: 'https://a26d-182-191-132-237.ngrok-free.app/quickbooks/callback'
}
# oauth2_client = OAuth2::Client.new(ENV['OAUTH_CLIENT_ID'], ENV['OAUTH_CLIENT_SECRET'], oauth_params)
$qb_oauth_client = OAuth2::Client.new('ABZyS4JhYo1u5iYpqG2fm7ePdYjwIVAnyp0HtHflEjvUQRrf7O',
                                      '0j5j5mrfgqJfY6xtoAGhvKZvem9tDTgbSAPy8Q6U', oauth_params)
