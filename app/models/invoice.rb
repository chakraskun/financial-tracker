class Invoice
  include Userable
  include Invoices::Attachable
  include Mongoid::Document
  include Mongoid::Timestamps

  # has_mongoid_attached_file :proof_of_transaction
  has_one :invoice_attachment
  belongs_to :monthly_plan
  belongs_to :shopping_list

  field :invoice_type, type: String
  field :description, type: String
  field :user_id, type: String
  field :price, type: Money
  field :date, :type => DateTime
  field :monthly_plan_id, type: String
  field :shopping_list_id, type: String
  field :invoice_attachment_id, type: String
  field :attachment_link, type: String

  validates :price, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  validates :monthly_plan_id, presence: true
  validates :invoice_type, :inclusion => { :in => ["income", "expense"] }
  # validates_attachment :proof_of_transaction, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end