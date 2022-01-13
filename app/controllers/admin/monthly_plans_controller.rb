# frozen_string_literal: true

module Admin
  class MonthlyPlansController < Admin::ApplicationController
    before_action :monthly_plan, only: %i[show edit update]

    def index
      @new_monthly_plan = MonthlyPlan.new
    end

    def show; end
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

    private
      def monthly_plan
        @plan ||= MonthlyPlan.find_by(id: params[:id])
      end
  end
end
