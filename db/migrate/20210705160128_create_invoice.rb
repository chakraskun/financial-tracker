class CreateInvoice < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices, id: :uuid do |t|
      
      t.string :name
      t.monetize :price
      t.string :description
      t.timestamps
    end
  end
end
