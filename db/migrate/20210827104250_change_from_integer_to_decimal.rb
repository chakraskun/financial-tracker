class ChangeFromIntegerToDecimal < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoices, :price_cents
    remove_column :projects, :price_cents

    change_table :invoices do |t|
      t.decimal :price_cents, default: "0.0", null: false
    end

    change_table :projects do |t|
      t.decimal :price_cents, default: "0.0", null: false
    end
  end
end
