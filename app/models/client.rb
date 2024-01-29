# frozen_string_literal: true

class Client < ApplicationRecord
  has_one :user, as: :userable

  has_many :activities
  has_many :notes
end
