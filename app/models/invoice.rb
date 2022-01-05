class Invoice
  include Userable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :invoice_type, type: String
  field :description, type: String
  field :user_id, type: String
  field :price, type: Money
  field :date, :type => DateTime

  validates :price, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :invoice_type, :inclusion => { :in => ["income", "expense"] }

end