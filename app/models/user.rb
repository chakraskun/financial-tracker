class User < ApplicationRecord
  rolify
  include Clearance::User
  include PgSearch::Model
end
