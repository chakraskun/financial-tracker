module MonthlyPlanLines
  module Helpers extend ActiveSupport::Concern
    
    def month
      return @monthly if @monthly.present?
      @monthly = MonthlyPlan.find_by(id: self.monthly_plan_id)
    end
  end
end