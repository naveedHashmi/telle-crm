# frozen_string_literal: true

class RemoveUserAssociationWithClientAndLeads < ActiveRecord::Migration[7.0]
  def up
    add_column :leads, :name, :string, default: '', null: false
    add_column :clients, :name, :string, default: '', null: false
    add_column :clients, :email, :string, default: '', null: false

    User.where(userable_type: 'Lead').find_each do |user|
      user.userable_type.constantize.update(name: user.name)
    end

    User.where(userable_type: 'Client').find_each do |user|
      user.userable_type.constantize.update(name: user.name, email: user.email)
    end

    User.where(userable_type: %w[Lead Client]).destroy_all

    remove_reference :users, :userable
    remove_column :users, :userable_type
  end

  def down
    remove_column :users, :userable_type

    Lead.all.each do |lead|
      User.create(name: lead.name, userable_type: 'Lead', userable_id: lead.id)
    end

    Client.all.each do |client|
      User.create(name: client.name, email: client.email, userable_type: 'Client', userable_id: client.id)
    end

    remove_column :clients, :email
    remove_column :clients, :name
    remove_column :leads, :name
    add_reference :users, :userable, polymorphic: true, null: true
  end
end
