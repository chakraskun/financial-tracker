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
      if invoice_attachment.present? && Rails.env == 'production'
        invoice.attachment_link = invoice_attachment.proof_of_transaction.url
      end
      invoice.invoice_attachment_id = invoice_attachment.id
      invoice.save!
    end

    def invoice
      @invoice ||= Invoice.new(invoice_params)
    end
  end
end
