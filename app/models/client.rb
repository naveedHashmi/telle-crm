# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :activities, as: :assignee, dependent: :destroy
  has_many :notes, as: :noteable, dependent: :destroy

  before_destroy :delete_associated_user

  private

  def delete_associated_user
    user&.destroy
  end
end
