class Invoice
  include Userable
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  has_mongoid_attached_file :proof_of_transaction
  belongs_to :monthly_plan
  belongs_to :shopping_list

  field :invoice_type, type: String
  field :description, type: String
  field :user_id, type: String
  field :price, type: Money
  field :date, :type => DateTime
  field :monthly_plan_id, type: String
  field :shopping_list_id, type: String

  validates :price, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :monthly_plan_id, presence: true
  validates :invoice_type, :inclusion => { :in => ["income", "expense"] }
end