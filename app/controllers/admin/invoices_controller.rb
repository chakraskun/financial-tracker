# frozen_string_literal: true

module Admin
  class InvoicesController < Admin::ApplicationController
    before_action :invoice, only: %i[show edit download update_document_transaction]

    def index
      @total_expense = Invoice.expense.sum(&:price).to_money
      @total_income = Invoice.income.sum(&:price).to_money
      @current_balance = @total_income - @total_expense
    end

    def show
    end

    def create
      service = ::Invoices::CreateService.new(
        invoice_params,
        current_user.id
      )

      if !service.run
        return redirect_to admin_invoices_path,
          alert: "Failed to create invoice, #{service.error_messages.to_sentence}"
      end
      redirect_to admin_invoice_path(id: service.invoice.id), notice: "Invoice has been created"
    end

    def destroy
      if !invoice.destroy

        flash[:danger] = "Failed to delete invoice. #{shipper.errors.full_messages.to_sentence}"
        return redirect_to admin_invoices_path
      end

      redirect_to admin_invoices_path,
        flash: { success: 'Success delete Invoice' }
    end

    private
    def invoice
      @invoice ||= Invoice.find_by_id(params[:id])
    end

    def invoice_params
      @invoice_params = params.permit(
        :name, :price, :description, :type, :date, :invoice_type
      )
    end
    
  end
end
