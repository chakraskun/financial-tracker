class MonthlyPlanLine
  include MonthlyPlanLines::Helpers
  include Mongoid::Document
  include Mongoid::Timestamps

  field :shopping_list_id, type: String
  field :price, type: Money
  field :monthly_plan_id, type: String
  
  validates :price, presence: true
  validates :shopping_list_id, presence: true
  validates :monthly_plan_id, presence: true
end