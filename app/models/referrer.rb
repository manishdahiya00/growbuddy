class Referrer < ApplicationRecord
  belongs_to :app_offer
  belongs_to :affiliate
end
