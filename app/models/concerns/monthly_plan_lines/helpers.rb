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

    def invoices
      return @invoices if @invoices.present?
      @invoices = Invoice.where(monthly_plan_id: self.monthly_plan_id, shopping_list_id: self.shopping_list_id)
    end

    def price_realization
      return @price_realization if @price_realization.present?
      @price_realization = Invoice.where(shopping_list_id: self.shopping_list_id, monthly_plan_id: self.monthly_plan_id).sum(&:price).to_money
    end
    
    def invoice_realization
      return @invoice_realization if @invoice_realization.present?
      @invoice_realization = Invoice.where(shopping_list_id: self.shopping_list_id)
    end

    def overbudget?
      return false if self.price_realization < self.price
      return true
    end

    def remaining_budget
      return @remaining_budget if @remaining_budget.present?
      @remaing_budget = self.price - self.price_realization
    end
    
    def colorization
      if price_realization >= price
        return '#FF6961'
      elsif price_realization/price >= 0.5
        return '#F8D66D'
      else
        return '#8CD47E'
      end
    end

    def percentage_realization
      return @percentage_realization if @percentage_realization.present?
      @percentage_realization = (price_realization/price*100).round(0)
    end
    
    
    
  end
end