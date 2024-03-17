class CreateInvoiceQueues < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_queues do |t|
      t.string :full_name, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :full_address, null: false, default: ''
      t.string :phone_no, null: false, default: ''
      t.float :invoice_amount, null: false, default: 0
      t.string :claim_no, null: false, default: ''
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :approved_by, foreign_key: { to_table: :users }, optional: true

      t.timestamps
    end
  end
end
