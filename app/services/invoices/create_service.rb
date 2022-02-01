# frozen_string_literal: true

module Invoices
  class CreateService < ::Invoices::BaseService
    def action
      invoice.user_id = @current_user
      invoice.save!
    end

    def invoice
      @invoice ||= Invoice.new(invoice_params)
    end
  end
end
