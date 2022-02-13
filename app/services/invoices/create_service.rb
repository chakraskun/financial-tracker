# frozen_string_literal: true

module Invoices
  class CreateService < ::Invoices::BaseService
    def action
      invoice.user_id = @current_user
      if invoice_attachment_params['proof_of_transaction'].present?
        invoice_attachment = InvoiceAttachment.new(invoice_attachment_params)
        invoice_attachment.file_name = invoice_attachment_params['proof_of_transaction'].original_filename
        invoice_attachment.save!
      end
      invoice.save!
    end

    def invoice
      @invoice ||= Invoice.new(invoice_params)
    end
  end
end
