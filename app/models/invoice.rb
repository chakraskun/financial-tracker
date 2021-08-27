class Invoice < ApplicationRecord
  belongs_to :project, optional: true
  monetize :price_cents

  enum invoice_type: {
    income: "income",
    expense: "expense"
  }
end
