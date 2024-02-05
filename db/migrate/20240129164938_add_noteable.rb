# frozen_string_literal: true

class AddNoteable < ActiveRecord::Migration[7.0]
  def change
    Note.destroy_all
    add_reference :notes, :noteable, polymorphic: true, null: false
    remove_reference :notes, :client, index: true, foreign_key: true
  end
end
