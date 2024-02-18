class Deal < ApplicationRecord
  include Filterable

  belongs_to :client

  enum :status, { agreement_start: 0, agreement_signed: 1, claim_initiated: 3, checklist_sent: 4, waiting_on_docs: 5,
                  claim_submitted: 6, claim_approved: 7, invoice_sent: 8, invoice_paid: 9, invoice_closed: 10 }, instance_methods: false
  # Validations
  validates :claim_no, presence: true
  validates :amount_owed, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fee_percent, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :status, presence: true, inclusion: { in: %w[agreement_start agreement_signed claim_initiated checklist_sent waiting_on_docs claim_submitted claim_approved invoice_sent invoice_paid invoice_closed] } # Assuming status can be 0, 1, or 2
  validates :expected_commission, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :filter_by_status, ->(status) { where(status:) }
end
