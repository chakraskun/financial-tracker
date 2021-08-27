class ChangeTypeToInvoiceTypeOnInvoice < ActiveRecord::Migration[6.1]
  def change
    rename_column :invoices, :type, :invoice_type
  end
end
