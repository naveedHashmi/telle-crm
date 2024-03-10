# frozen_string_literal: true

class DealsController < BaseController
  before_action :set_deal, only: %i[show edit update destroy]

  # GET /deals or /deals.json
  def index
    client_deals = current_user.deals.custom_filter(filter_params).includes(:client)
    @deals = client_deals.group_by(&:status)
    @deals_group = client_deals.group(:status).count
  end

  # GET /deals/1 or /deals/1.json
  def show; end

  # GET /deals/new
  def new
    @deal = Deal.new
  end

  # GET /deals/1/edit
  def edit; end

  # POST /deals or /deals.json
  def create
    @deal = Deal.new(deal_params)

    respond_to do |format|
      if @deal.save
        format.html { redirect_to deals_path, notice: 'Deal was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    deal = Deal.find_by(id: params[:id])

    if deal.update(status: params[:status])
      render json: deal, status: :ok
    else
      render json: deal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deals/1 or /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to deals_path, notice: 'Deal was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1 or /deals/1.json
  def destroy
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_deal
    @deal = Deal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def deal_params
    params.require(:deal).permit(:claim_no, :amount_owed, :fee_percent, :status, :expected_commission, :client_id,
                                 :included)
  end

  def filter_params
    params['filter'] || {}
  end
end
