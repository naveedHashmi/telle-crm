# frozen_string_literal: true

class Lead < ApplicationRecord
  has_one :user, as: :userable
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :activities, as: :assignee, dependent: :destroy

  enum status: { Alive: 0, Diseased: 1, Unknown: 2 }
end
