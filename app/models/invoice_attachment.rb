class InvoiceAttachment < ApplicationRecord
  has_one_attached :proof_of_transaction
end
