# frozen_string_literal: true

module Admin
  class InvoicesController < Admin::ApplicationController
    before_action :invoice, only: %i[show edit]
    before_action :selection_list, only: %i[index edit ajax_dropdown_name]

    def index
      @total_expense = Invoice.expense.sum(&:price).to_money
      @total_income = Invoice.income.sum(&:price).to_money
      @current_balance = @total_income - @total_expense
    end

    def show
    end

    def ajax_dropdown_name
      if params["invoice_type"] == 'expense'
        render json: {
          dropdown_html: render_to_string(
            partial: 'admin/invoices/partials/dropdown_name_list',
            locals: {dropdown_list: @expense_list}
          )
        }
      else
        render json: {
          dropdown_html: render_to_string(
            partial: 'admin/invoices/partials/dropdown_name_list',
            locals: {dropdown_list: @income_list}
          )
        }
      end
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
      redirect_to admin_invoices_path, notice: "Invoice has been created"
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
    
    def selection_list
      @income_list = ['Ratu Meti','Asni Djamil']
      @expense_list = [
        'Wedding Organizer',
        'MUA',
        'Venue',
        'Shoes - Bride & Groom',
        'Shoes - Moms & Sisters',
        'Attire - Bride & Groom',
        'Attire - Moms & Sisters',
        'Administrative',
        'Others'
      ]
    end
  end
end
