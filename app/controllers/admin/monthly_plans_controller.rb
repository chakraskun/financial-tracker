# frozen_string_literal: true

module Admin
  class MonthlyPlansController < Admin::ApplicationController
    before_action :monthly_plan, only: %i[show edit update]
    before_action :selection_list, only: %i[show]

    def index
      @new_monthly_plan = MonthlyPlan.new
    end

    def show
    end

    def edit; end

    def create
      service = ::MonthlyPlans::CreateService.new(
        params,
        current_user.id
      )
      unless service.run
        return redirect_to admin_invoices_path,
          alert: "Failed to create monthly plan, #{service.error_messages.to_sentence}"
      end
      redirect_to admin_monthly_plan_path(id: service.monthly.id), notice: "Monthly Plan has been created"
    end

    def destroy
      if !invoice.destroy
        flash[:danger] = "Failed to delete invoice. #{shipper.errors.full_messages.to_sentence}"
        return redirect_to admin_invoices_path
      end
      redirect_to admin_invoices_path,
        flash: { success: 'Success delete Invoice' }
    end

    def ajax_dropdown_name
      if params["invoice_type"] == 'expense'
        render json: {
          dropdown_html: render_to_string(
            partial: 'admin/monthly_plans/partials/dropdown_name_list',
            locals: {dropdown_list: @expense_list}
          )
        }
      else
        render json: {
          dropdown_html: render_to_string(
            partial: 'admin/monthly_plans/partials/dropdown_name_list',
            locals: {dropdown_list: @income_list}
          )
        }
      end
    end

    private
      def monthly_plan
        @plan ||= MonthlyPlan.find_by(id: params[:id])
      end

      def selection_list
        @income_list = ['Chakras Andika','Vannia Alfiani']
        @expense_list = @plan.expense_selection_list
      end
  end
end
