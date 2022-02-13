module Invoices
  module Attachable extend ActiveSupport::Concern
  
    def attachment
      InvoiceAttachment
        .where(id: self.invoice_attachment_id)
        .first
        .proof_of_transaction
    end
  end 
end