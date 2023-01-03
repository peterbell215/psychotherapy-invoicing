# frozen_string_literal: true

# Provides details of a client including address.
class Client < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :session_charges, dependent: :destroy

  # There must be at least one session charge setup for the client
  validates :session_charges, presence: true
  validate :session_charges_must_not_overlap

  after_initialize { |client| client.session_charges.build(from: Time.zone.today, hourly_charge_rate: 60) }

  # @return Money
  def default_session_charge
    if self.id
      self.session_charges.find_by(to: nil).hourly_charge_rate
    else
      self.session_charges.find { |session_charge| session_charge.to.nil? }.hourly_charge_rate
    end
  end

  def session_charges_must_not_overlap
    overlap_error = SessionCharge.overlap?(self.session_charges)

    if overlap_error
      self.errors.add(:session_charges, "Session charge to #{overlap_error.to} overlaps with its successor")
    end
  end
end
