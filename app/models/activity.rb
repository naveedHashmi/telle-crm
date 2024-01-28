# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :client

  enum priority: { Regular: 0, High: 1, Urgent: 2 }
end
