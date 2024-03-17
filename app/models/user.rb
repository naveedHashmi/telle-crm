# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable
  enum role: { admin: 0, super_admin: 1 }

  belongs_to :userable, polymorphic: true, optional: true

  has_many :clients
  has_many :leads
  has_many :deals, through: :clients
  has_many :invoice_queues
  has_many :approved_invoices, class_name: 'InvoiceQueue', foreign_key: 'approved_by_id'

  validate :name, prepend: true
end
