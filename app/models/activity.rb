# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :assignee, polymorphic: true

  enum priority: { Regular: 0, High: 1, Urgent: 2 }
end
