class AppOffer < ApplicationRecord
  has_many :offer_events, dependent: :destroy
  has_many :referrers, dependent: :destroy
  scope :active, -> { where(status: true).order(created_at: :desc) }
end
