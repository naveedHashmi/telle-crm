class AddDocusignTemplateIdToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :docusign_template_id, :string, defautl: ''
  end
end
