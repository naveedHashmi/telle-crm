# frozen_string_literal: true

class LeadsController < BaseController
  before_action :set_lead, only: %i[show edit update destroy]

  include LeadsHelper
  # GET /leads or /leads.json
  def index
    @leads = Lead.all

    @leads = @leads.where(label_id: [JSON.parse(params[:label_id])].flatten) if params[:label_id].present?
    @leads = @leads.custom_filter(filter_params)
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
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to leads_path, notice: 'Client successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /leads/1 or /leads/1.json
  def update
    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @lead.update(lead_params)

          format.html { redirect_to lead_url(@lead), notice: 'Lead was successfully updated.' }
          format.json { render :show, status: :ok, location: @lead }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @lead.errors, status: :unprocessable_entity }
        end
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

  def upload_csv; end

  def mappings
    @file = params[:file]
    @headers = CSV.open(@file.path, 'r', &:readline)
    respond_to(&:turbo_stream)
  end

  def process_csv
    file_path = params[:file].path
    filtered_params = params.select { |_key, value| dropdwon_mappings.keys.include?(value) }.permit!.to_h.invert

    ActiveRecord::Base.transaction do
      CSV.foreach(file_path, headers: true) do |row|
        status = row[filtered_params['status']]
        amount_owed = row[filtered_params['amount_owed']].gsub(/[^\d]/, '').to_i
        property_sold = row[filtered_params['property_sold']]
        county = row[filtered_params['county']]
        date_sold = begin
          Date.parse(row[filtered_params['date_sold']])
        rescue StandardError
          nil
        end
        mortgage_company = row[filtered_params['mortgage_company']]
        initial_bid_amount = row[filtered_params['initial_bid_amount']].gsub(/[^\d]/, '').to_i
        sold_amount = row[filtered_params['sold_amount']].gsub(/[^\d]/, '').to_i
        label = row[filtered_params['label']]
        name = row[filtered_params['name']]

        model_label = Label.find_by(name: label)
        model_lead = User.where(userable_type: 'Lead').find_by(name:)
        model_label ||= Label.create(name: label)

        next if model_lead.present?

        lead = Lead.find_or_initialize_by(status:, amount_owed:,
                                          initial_bid_amount:, property_sold:, county:, date_sold:, mortgage_company:,
                                          sold_amount:, label: model_label)
        User.create!(name:, userable: lead) if lead.save
      end
    end

    redirect_to leads_url
  end

  def change_assignee
    Lead.where(id: params[:lead_ids]).update_all(user_id: params[:assignee_id])
    @leads = current_user.leads
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lead_params
    params.require(:lead).permit(:status, :amount_owed, :property_sold, :county, :date_sold, :mortgage_company,
                                 :initial_bid_amount, :sold_amount, :label_id, :name, :lawsuit_no, :user_id)
  end

  def filter_params
    params['filter'] || {}
  end

  def user_params
    params.require(:lead).permit(:name, :email)
  end
end
