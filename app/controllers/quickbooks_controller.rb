class QuickbooksController < ApplicationController
  def authorize
    redirect_uri = quickbooks_callback_url
    grant_url = $qb_oauth_client.auth_code.authorize_url(redirect_uri:, response_type: 'code',
                                                         state: SecureRandom.hex(12), scope: 'com.intuit.quickbooks.accounting')
    redirect_to grant_url, allow_other_host: true
  end

  def callback
    if params[:state].present?
      # use the state value to retrieve from your backend any information you need to identify the customer in your system
      redirect_uri = quickbooks_callback_url
      if resp = $qb_oauth_client.auth_code.get_token(params[:code], redirect_uri:)
        # save your tokens here. For example:
        # quickbooks_credentials.update_attributes(access_token: resp.token, refresh_token: resp.refresh_token, realm_id: params[:realmId])
        # byebug
      end
    end
    redirect_to root_path, notice: 'Successfully connected to QuickBooks!'
  end
end
