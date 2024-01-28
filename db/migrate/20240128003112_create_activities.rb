# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.date :date
      t.string :to_do
      t.references :client, null: false, foreign_key: true
      t.integer :priority

      t.timestamps
    end
  end
end
