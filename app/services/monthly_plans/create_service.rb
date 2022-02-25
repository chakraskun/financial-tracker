# frozen_string_literal: true

module MonthlyPlans
  class CreateService < ::MonthlyPlans::BaseService

    def action
      monthly.user_id = @current_user
      monthly.save!
      if monthly_lines_params.present?
        monthly_lines_params.each do |i,line_params|
          plan_line = MonthlyPlanLine.new(line_params)
          plan_line.monthly_plan_id = monthly.id
          plan_line.save!
        end
      end
    end

    def monthly
      @monthly ||= MonthlyPlan.new(monthly_params)
    end
  end
end
