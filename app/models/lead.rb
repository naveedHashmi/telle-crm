# frozen_string_literal: true

class Lead < ApplicationRecord
  include Filterable

  belongs_to :label
  belongs_to :user
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :activities, as: :assignee, dependent: :destroy

  enum status: { Alive: 0, Deceased: 1, Unknown: 2 }

  scope :filter_by_user_id, ->(user_id) { where(user_id:) }
end
