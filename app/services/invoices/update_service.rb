# frozen_string_literal: true

module Invoices
  class UpdateService < BaseService
    def initialize params_id, invoice_params, current_user_id
      @params_id = params_id
      @invoice_params = invoice_params
      @current_user_id = current_user_id
    end

    def action
      @invoice = Invoice.find_by(
        id: @params_id
      )
      @invoice.date = @invoice_params['date']
      @invoice.description = @invoice_params['description']
      @invoice.price = @invoice_params['price']
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
