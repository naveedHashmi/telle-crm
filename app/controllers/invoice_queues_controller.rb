class InvoiceQueuesController < BaseController
  before_action :set_invoice_queue, only: %i[show edit update destroy approve]

  # GET /invoice_queues or /invoice_queues.json
  def index
    @invoice_queues = InvoiceQueue.all
  end

  # GET /invoice_queues/1 or /invoice_queues/1.json
  def show; end

  # GET /invoice_queues/new
  def new
    @invoice_queue = InvoiceQueue.new
  end

  # GET /invoice_queues/1/edit
  def edit; end

  # POST /invoice_queues or /invoice_queues.json
  def create
    @invoice_queue = InvoiceQueue.new(invoice_queue_params)
    if @invoice_queue.save
      flash[:notice] = 'Invoice queue was successfully created'
    else
      flash[:alert] = 'Invoice queue was not successfully created'
    end
  end

  # PATCH/PUT /invoice_queues/1 or /invoice_queues/1.json
  def update
    respond_to do |format|
      if @invoice_queue.update(invoice_queue_params)
        format.html { redirect_to invoice_queue_url(@invoice_queue), notice: 'Invoice queue was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_queue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  def approve
    if @invoice_queue.update(status: :approved, approved_by: current_user)
      flash[:notice] = 'Invoice queue approved successfully'
    else
      flash[:alert] = "Invoice queue not approved due to #{@invoice_queue.errors.full_messages}"
    end
    redirect_to invoice_queues_path
  end

  # DELETE /invoice_queues/1 or /invoice_queues/1.json
  def destroy
    @invoice_queue.destroy

    respond_to do |format|
      format.html { redirect_to invoice_queues_url, notice: 'Invoice queue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice_queue
    @invoice_queue = InvoiceQueue.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def invoice_queue_params
    params.require(:invoice_queue).permit(:full_name, :email, :full_address, :phone_no, :invoice_amount, :claim_no,
                                          :user_id, :approved_by_id).merge(user_id: current_user.id)
  end
end
