# frozen_string_literal: true

class Lead < ApplicationRecord
  include Filterable

  belongs_to :label
  belongs_to :user
  has_many :notes, as: :noteable, dependent: :destroy
  has_many :activities, as: :assignee, dependent: :destroy
  has_one :family_tree, as: :family_treeable, dependent: :destroy

  validate :only_one_family_tree

  enum status: { Alive: 0, Deceased: 1, Unknown: 2 }

  scope :filter_by_user_id, ->(user_id) { where(user_id:) }

  private

  def only_one_family_tree
    return unless FamilyTree.where(family_treeable_type: 'Lead', family_treeable_id: id).count > 1

    errors.add(:base, 'can only have one family tree')
  end
end
