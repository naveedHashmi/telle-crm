# frozen_string_literal: true

class Activity < ApplicationRecord
  include Filterable

  belongs_to :assignee, polymorphic: true

  enum priority: { Regular: 0, High: 1, Urgent: 2 }
  enum status: { Uncomplete: 0, Complete: 1 }

  validates :priority, inclusion: { in: %w[Regular High Urgent] }
  validates :status, inclusion: { in: %w[Uncomplete Complete] }

  scope :filter_by_status, ->(status) { where(status:) }
end
