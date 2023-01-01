# frozen_string_literal: true

# Provides details of a client including address.
class Client < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :session_charges, dependent: :destroy

  # There must be at least one session charge setup for the client
  validates :session_charges, presence: true

  after_initialize { |client| client.session_charges.build(from: Date.today, hourly_charge_rate: 60) }

  # @return Money
  def default_session_charge
    self.session_charges.find_by(to: nil).hourly_charge_rate
  end
end
