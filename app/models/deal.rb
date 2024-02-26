# frozen_string_literal: true

class Deal < ApplicationRecord
  include Filterable

  belongs_to :client

  enum :status, { agreement_start: 0, agreement_signed: 1, initiated: 3, checklist_sent: 4, waiting_on_docs: 5,
                  submitted: 6, approved: 7, sent: 8, paid: 9, closed: 10 }, instance_methods: false
  # Validations
  validates :claim_no, presence: true
  validates :amount_owed, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fee_percent, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :status, presence: true, inclusion: { in: %w[agreement_start agreement_signed initiated checklist_sent waiting_on_docs submitted approved sent paid closed] } # Assuming status can be 0, 1, or 2
  validates :expected_commission, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :filter_by_status, ->(status) { where(status:) }
  scope :filter_by_user_id, ->(user_id) { joins(client: :user).where(users: { id: user_id }) }
end
