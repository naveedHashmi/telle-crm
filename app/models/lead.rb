# frozen_string_literal: true

class Lead < ApplicationRecord
  has_one :user, as: :userable
  belongs_to :label
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :activities, as: :assignee, dependent: :destroy

  enum status: { Alive: 0, Deceased: 1, Unknown: 2 }

  before_destroy :delete_associated_user

  private

  def delete_associated_user
    user&.destroy
  end
end
