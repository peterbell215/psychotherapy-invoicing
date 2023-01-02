class SessionCharge < ApplicationRecord
  belongs_to :client

  monetize :hourly_charge_rate_pence

  # Checks if for the provided client_id any session charge entries' date ranges overlap.
  # @param [ActiveResult] session_charges
  # @return [SessionCharge|false]
  def self.overlap?(session_charges)
    overlapping_pair = session_charges.each_cons(2).find { |previous, following| previous.to >= following.from }
    overlapping_pair&.first
  end
end
