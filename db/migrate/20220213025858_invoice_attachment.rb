class InvoiceAttachment < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_attachments, id: :uuid do |t|
      t.string :file_name, null: false
      t.timestamps null: false
    end
  end
end
