# frozen_string_literal: true

class Lead < ApplicationRecord
  include Filterable

  belongs_to :label
  belongs_to :user
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :activities, as: :assignee, dependent: :destroy

  enum status: { Alive: 0, Deceased: 1, Unknown: 2 }

  before_destroy :delete_associated_user

  scope :filter_by_user_id, ->(user_id) { where(user_id:) }

  private

  def delete_associated_user
    user&.destroy
  end
end
