class Affiliate < ApplicationRecord
  has_many :referrers, dependent: :destroy
end
