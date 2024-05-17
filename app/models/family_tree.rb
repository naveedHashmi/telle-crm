# frozen_string_literal: true

class FamilyTree < ApplicationRecord
  belongs_to :family_treeable, polymorphic: true
  has_one :tree_node, as: :parent_node, dependent: :destroy
  accepts_nested_attributes_for :tree_node

  validates_with FamilyTreeValidator
end
