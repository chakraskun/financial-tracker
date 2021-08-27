class AddDateToInvoice < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :date, :datetime
  end
end
