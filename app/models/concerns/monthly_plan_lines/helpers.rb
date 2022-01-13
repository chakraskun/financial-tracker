module MonthlyPlanLines
  module Helpers extend ActiveSupport::Concern
    
    def month
      return @monthly if @monthly.present?
      @monthly = MonthlyPlan.find_by(id: self.monthly_plan_id)
    end

    def shopping_list
      return @shopping_list if @shopping_list.present?
      @shopping_list = ShoppingList.find_by(id: self.shopping_list_id)
    end
  end
end