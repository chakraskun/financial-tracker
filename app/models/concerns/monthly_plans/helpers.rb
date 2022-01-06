module MonthlyPlans
  module Helpers extend ActiveSupport::Concern
    def lines
      return @lines if @lines.present?
      @lines = MonthlyPlanLine.where(monthly_plan_id: self.id)
    end
  end
end