class FamilyTreeValidator < ActiveModel::Validator
  attr_accessor :record

  def validate(record)
    self.record = record

    unique_client
  end

  def unique_client
    record.errors.add(:family_treeable, 'has already a family tree') if record.family_treeable.family_tree.persisted?
  end
end
