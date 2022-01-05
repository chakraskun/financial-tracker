# frozen_string_literal: true

module MonthlyPlans
  class CreateService < BaseService
    def initialize monthly_plan_params, current_user_id
      @monthly_plan_params = monthly_plan_params
      @current_user_id = current_user_id
    end

    def action
      @monthly_plan = MonthlyPlan.new(@monthly_plan_params)
      @monthly_plan.user_id = @current_user_id
      @monthly_plan.save!
    end

    def monthly_plan
      return @monthly_plan
    end

    def errors
      return @monthly_plan.errors
    end
  end
end
