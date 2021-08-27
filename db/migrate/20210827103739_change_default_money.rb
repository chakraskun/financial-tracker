class ChangeDefaultMoney < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoices, :price_currency
    remove_column :projects, :price_currency

    change_table :invoices do |t|
      t.string :price_currency, default: "IDR", null: false
    end

    change_table :projects do |t|
      t.string :price_currency, default: "IDR", null: false
    end
  end
end
