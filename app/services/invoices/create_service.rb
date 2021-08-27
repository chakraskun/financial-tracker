# frozen_string_literal: true

module Invoices
  class CreateService < BaseService
    def initialize invoice_params, current_user_id
      @invoice_params = invoice_params
      @current_user_id = current_user_id
    end

    def action
      @invoice = Invoice.new(@invoice_params)
      @invoice.user_id = @current_user_id
      @invoice.save!
    end

    def invoice
      return @invoice
    end

    def errors
      return @invoice.errors
    end
  end
end
