class AddUserIdAndTypeToInvoice < ActiveRecord::Migration[6.1]
  def change
    add_reference :invoices, :user, null: true, foreign_key: true, type: :uuid
    add_column :invoices, :type, :string
  end
end
