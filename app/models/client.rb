# frozen_string_literal: true

# Provides details of a client including address.
class Client < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :session_charges, dependent: :destroy

  # There must be at least one session charge setup for the client
  validates :session_charges, presence: true
  validate :session_charges_must_not_overlap

  after_initialize { |client| client.session_charges.build(from: Date.today, hourly_charge_rate: 60) }

  # @return Money
  def default_session_charge
    self.session_charges.find_by(to: nil).hourly_charge_rate
  end

  def session_charges_must_not_overlap
    overlap_error = SessionCharge.overlap?(self.id)

    self.errors.add(:session_charges, "Session charge to #{overlap_error.to} overlaps with its successor  ") if overlap_error
  end
end
