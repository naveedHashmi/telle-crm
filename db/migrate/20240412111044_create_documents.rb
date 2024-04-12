class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name, default: '', null: false
      t.boolean :is_private, default: false, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
