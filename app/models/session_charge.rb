class SessionCharge < ApplicationRecord
  belongs_to :client

  monetize :hourly_charge_rate_pence

  # Checks if for the provided client_id any session charge entries' date ranges overlap.
  # @param [BigInt] client_id
  # @return [SessionCharge|false]
  def self.overlap?(client_id)
    SessionCharge.where(client_id: client_id).order(:from).each_with_object(nil) do |current, previous|
      return current if previous && previous.to >= current.from
      previous = current
    end
    false
  end
end
