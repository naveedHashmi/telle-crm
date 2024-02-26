# frozen_string_literal: true

class Client < ApplicationRecord
  include Filterable

  has_many :activities, as: :assignee, dependent: :destroy
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :deals

  before_destroy :delete_associated_user

  scope :filter_by_user_id, ->(user_id) { where(user_id:) }

  private

  def delete_associated_user
    user&.destroy
  end
end
