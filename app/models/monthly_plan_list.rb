class MonthlyPlanList
  include Mongoid::Document
  include Mongoid::Timestamps

  field :list_type, type: String
  field :price, type: Money
  field :date, :type => DateTime
  
  validates :price, presence: true
  validates :date, presence: true
  validates :list_type, presence: true
end