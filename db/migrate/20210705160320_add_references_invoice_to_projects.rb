class AddReferencesInvoiceToProjects < ActiveRecord::Migration[6.1]
  def change
    add_reference :invoices, :project, null: false, foreign_key: true, type: :uuid
  end
end
