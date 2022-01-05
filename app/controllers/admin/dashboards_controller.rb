# frozen_string_literal: true

module Admin
  class DashboardsController < Admin::ApplicationController
    def index
      @total_expense = Invoice.where(invoice_type: 'expense').sum('price.cents').to_money
      @total_income = Invoice.where(invoice_type: 'income').sum('price.cents').to_money
      @current_balance = @total_income - @total_expense
    end
  end
end
