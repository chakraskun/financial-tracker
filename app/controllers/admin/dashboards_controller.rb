# frozen_string_literal: true

module Admin
  class DashboardsController < Admin::ApplicationController
    def index
      @total_expense = Invoice.expense.sum(&:price)&.to_money
      @total_income = Invoice.income.sum(&:price)&.to_money
      @current_balance = @total_income - @total_expense
    end
  end
end
