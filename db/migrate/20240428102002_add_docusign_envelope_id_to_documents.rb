class AddDocusignEnvelopeIdToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :docusign_envelope_id, :string, defautl: ''
  end
end
