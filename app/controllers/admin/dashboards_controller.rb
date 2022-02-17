# frozen_string_literal: true

module Admin
  class DashboardsController < Admin::ApplicationController
    def index
      current_month = Date.current.strftime('%B %Y')
      current_monthly_plan_id = MonthlyPlan.find_by(month: current_month).id
      expenses = Invoice.where(monthly_plan_id: current_monthly_plan_id)

      @calendar_expense = []
      expenses.map do |expense|
        y = {
          'title': expense.price.format,
          'start': expense.date.to_date,
          'description': expense.description
        }
        @calendar_expense << y
      end
    end
  end
end
