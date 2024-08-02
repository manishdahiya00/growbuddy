class AppBanner < ApplicationRecord
  scope :active, -> { where(status: true) }
end
