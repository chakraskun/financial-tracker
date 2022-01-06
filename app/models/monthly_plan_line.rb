class MonthlyPlanLine
  include Mongoid::Document
  include Mongoid::Timestamps

  field :list_type, type: String
  field :price, type: Money
  field :date, :type => DateTime
  field :monthly_plan_id, type: String
  
  validates :price, presence: true
  validates :date, presence: true
  validates :list_type, presence: true
  validates :monthly_plan_id, presence: true
end