# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.references :author, null: false, foreign_key: { to_table: :users, column: :author_id }
      t.references :client, null: false, foreign_key: true
      t.string :description, default: '', null: false

      t.timestamps
    end
  end
end
