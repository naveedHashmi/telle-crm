# frozen_string_literal: true

class ClientsController < BaseController
  before_action :set_client, only: %i[show edit update destroy]

  # GET /clients or /clients.json
  def index
    @clients = Client.custom_filter(filter_params)
  end

  # GET /clients/1 or /clients/1.json
  def show
    client_deals = @client.deals.custom_filter(filter_params).includes(:client)
    @deals = client_deals.group_by(&:status)
    @deals_group = client_deals.group(:status).count
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit; end

  # POST /clients or /clients.json

  def create
    @client = Client.new(client_params)

    if @client.save
      @clients = Client.custom_filter(filter_params)
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @client.update(client_params)
          format.html { redirect_to client_url(@client), notice: 'Client was successfully updated.' }
          format.json { render :show, status: :ok, location: @client }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_assignee
    Client.where(id: params[:client_ids]).update_all(user_id: params[:assignee_id])
    @clients = current_user.clients
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:phone, :amount_owed, :lawsuit_no, :address, :claim_no, :name, :email, :user_id)
  end

  def filter_params
    params['filter'] || {}
  end
end
