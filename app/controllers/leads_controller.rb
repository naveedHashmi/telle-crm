# frozen_string_literal: true

class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]

  # GET /leads or /leads.json
  def index
    @leads = Lead.all

    @leads = @leads.where(label_id: [JSON.parse(params[:label_id])].flatten) if params[:label_id].present?
  end

  # GET /leads/1 or /leads/1.json
  def show; end

  # GET /leads/new
  def new
    @lead = Lead.new
  end

  # GET /leads/1/edit
  def edit; end

  # POST /leads or /leads.json
  def create
    ActiveRecord::Base.transaction do
      @lead = Lead.new(lead_params)

      if @lead.save
        @user = User.create!(user_params.merge(userable: @lead))

        redirect_to leads_path, notice: 'Client successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /leads/1 or /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to lead_url(@lead), notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1 or /leads/1.json
  def destroy
    @lead.destroy

    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lead_params
    params.require(:lead).permit(:status, :amount_owed, :property_sold, :county, :date_sold, :mortgage_company,
                                 :initial_bid_amount, :sold_amount, :label_id)
  end

  def user_params
    params.require(:lead).permit(:name, :email)
  end
end
