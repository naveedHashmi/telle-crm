class QuickbooksController < ApplicationController
  before_action :quickbooks_service

  def authorize
    redirect_to @quickbooks_service.authorize_url, allow_other_host: true
  end

  def callback
    if params[:state].present? && resp = @quickbooks_service.get_token(params)
      @quickbooks_service.save_credentials(resp, params)
    end
    redirect_to root_path, notice: 'Successfully connected to QuickBooks!'
  end

  private

  def quickbooks_service
    @quickbooks_service ||= QuickbooksService.new
  end
end
