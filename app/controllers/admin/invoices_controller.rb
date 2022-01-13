# frozen_string_literal: true

module Admin
  class InvoicesController < Admin::ApplicationController
    before_action :invoice, only: %i[show edit update]
    before_action :selection_list, only: %i[index edit ajax_dropdown_name]

    def index
      @total_expense = Invoice.where(invoice_type: 'expense').sum(&:price)
      @total_income = Invoice.where(invoice_type: 'income').sum(&:price)
      @current_balance = @total_income - @total_expense
    end

    def show; end
    def edit; end

    def create
      service = ::Invoices::CreateService.new(
        params,
        current_user.id
      )
      if !service.run
        return redirect_to admin_invoices_path,
          alert: "Failed to create invoice, #{service.error_messages.to_sentence}"
      end
      redirect_to admin_monthly_plans_path, notice: "Invoice has been created"
    end

    # def update
    #   service = ::Invoices::UpdateService.new(
    #     params[:id],
    #     params['invoice'],
    #     current_user.id
    #   )
    #   if !service.run
    #     return redirect_to admin_invoices_path,
    #       alert: "Failed to update invoice, #{service.error_messages.to_sentence}"
    #   end
    #   redirect_to admin_invoices_path, notice: "Invoice has been updated"
    # end

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
