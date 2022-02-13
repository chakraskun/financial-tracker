module Invoices
  module Attachable extend ActiveSupport::Concern
  
    def attachment
      return @attachment if @attachment.present?
      @attachment = InvoiceAttachment
        .find_by(id: self.invoice_attachment_id)
        .proof_of_transaction
    end
  end 
end