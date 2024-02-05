# frozen_string_literal: true

class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    Lead.destroy_all

    create_table :labels do |t|
      t.string :name

      t.timestamps
    end

    add_reference :leads, :label, null: false, foreign_key: true
  end
end
