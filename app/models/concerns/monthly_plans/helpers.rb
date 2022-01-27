module MonthlyPlans
  module Helpers extend ActiveSupport::Concern
    def price
      return @price if @price.present?
      @price = MonthlyPlanLine.where(monthly_plan_id: self.id).sum(&:price) 
    end

    def expense_selection_list
      return @expense_selection_list if @expense_selection_list.present?
      shopping_list_ids = self.monthly_plan_lines.pluck(:shopping_list_id)
      @expense_selection_list = ShoppingList.where(:id.in => shopping_list_ids).map {|k| ["#{k.name}", k.id.to_str]}
    end

    def shopping_list_selection_list
      return @shopping_list_selection_list if @shopping_list_selection_list.present?
      @shopping_list_selection_list = ShoppingList.all.map {|k| ["#{k.name}", k.id.to_str]}
    end
  end
end