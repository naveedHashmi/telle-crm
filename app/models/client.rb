# frozen_string_literal: true

class Client < ApplicationRecord
  has_one :user, as: :userable

  has_many :activities, as: :assignee, dependent: :destroy
  has_many :notes, as: :noteable, dependent: :destroy
end
