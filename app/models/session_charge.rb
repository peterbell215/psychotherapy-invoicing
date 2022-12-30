class SessionCharge < ApplicationRecord
  belongs_to :client

  monetize :hourly_charge_rate_pence
end
