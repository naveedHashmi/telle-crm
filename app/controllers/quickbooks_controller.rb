class QuickbooksController < ApplicationController
  before_action :quickbooks_service

  def authorize
    redirect_to @quickbooks_service.authorize_url, allow_other_host: true
  end

  def callback
    # use the state value to retrieve from your backend any information you need to identify the customer in your system
    # save your tokens here. For example:
    # quickbooks_credentials.update_attributes(access_token: resp.token, refresh_token: resp.refresh_token, realm_id: params[:realmId])
    if params[:state].present? && resp = @quickbooks_service.get_token(params)
      # save your tokens here. For example:
      # quickbooks_credentials.update_attributes(access_token: resp.token, refresh_token: resp.refresh_token, realm_id: params[:realmId])
      # byebug
    end
    redirect_to root_path, notice: 'Successfully connected to QuickBooks!'
  end

  private

  def quickbooks_service
    @quickbooks_service ||= QuickbooksService.new
  end
end
