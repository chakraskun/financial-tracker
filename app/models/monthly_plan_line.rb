class MonthlyPlanLine
  include MonthlyPlanLines::Helpers
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :monthly_plan
  belongs_to :shopping_list

  field :shopping_list_id, type: String
  field :price, type: Money
  field :description, type: String
  field :monthly_plan_id, type: String
  
  validates :price, presence: true
  validates :shopping_list_id, presence: true
  validates :monthly_plan_id, presence: true
end