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
  def current_rate
    self.current_session_charge&.hourly_charge_rate
  end

  # Sets the current rate for sessions if different from current rate as held in database.  Updates the
  # current rate in the database to be up to yesterday, and creates a new session_charges record starting
  # today with an open ended charge period.
  # @return [Money]
  def current_rate=(rate)
    active_session_charge = self.current_session_charge

    if active_session_charge&.current_rate != rate
      active_session_charge&.update!(to: Date.today - 1.day)
      self.session_charges << SessionCharge.new(from: Date.today, to: nil, rate:)
    end

    rate
  end

  # Returns the current session_charge record.
  def current_session_charge
    if self.id
      self.session_charges.find_by(to: nil)
    else
      self.session_charges.find { |session_charge| session_charge.to.nil? }
    end
  end

  def session_charges_must_not_overlap
    overlap_error = SessionCharge.overlap?(self.session_charges)

    if overlap_error
      self.errors.add(:session_charges, "Session charge to #{overlap_error.to} overlaps with its successor")
    end
  end
end
