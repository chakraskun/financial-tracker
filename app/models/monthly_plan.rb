class MonthlyPlan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :month, type: String
  field :user_id, type: String
  validates :month, presence: true
  validates :user_id, presence: true
end