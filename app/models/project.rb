class Project < ApplicationRecord
  include PgSearch::Model
  has_many :invoice

  monetize :price_cents

  pg_search_scope :search,
    against: %i[consignee_name item_name receipt_number
      consignee_company_name ],
    using: {
      tsearch: { prefix: true, any_word: true, negation: true }
    }
end
