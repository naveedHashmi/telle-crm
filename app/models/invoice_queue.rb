class InvoiceQueue < ApplicationRecord
  belongs_to :user
  belongs_to :approved_by, class_name: 'User', optional: true

  enum status: { pending: 0, approved: 1 }
  validates :full_name, :email, :full_address, :phone_no, :invoice_amount, :claim_no, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_no, presence: true
  validates :invoice_amount, numericality: { greater_than_or_equal_to: 0 }
end
