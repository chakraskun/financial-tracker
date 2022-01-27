class MonthlyPlan
  include MonthlyPlans::Helpers
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :monthly_plan_lines, dependent: :destroy
  has_many :invoices, dependent: :destroy

  field :month, type: String
  field :user_id, type: String
  validates :month, presence: true
  validates :month, uniqueness: true
  validates :user_id, presence: true
end