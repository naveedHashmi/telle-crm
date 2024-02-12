class QuickbooksController < BaseController
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

  def customers
    intuit_account = QuickbooksCredential.first

    @customers = intuit_account.perform_authenticated_request do |access_token|
      service = Quickbooks::Service::Customer.new
      service.company_id = intuit_account.realm_id
      service.access_token = access_token
      service.query('Select Id, DisplayName, CompanyName, PrimaryPhone, Balance From Customer')
    end
  end

  private

  def quickbooks_service
    @quickbooks_service ||= QuickbooksService.new
  end
end
