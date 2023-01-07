# frozen_string_literal: true

# Provides details of a client including address.
class Client < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :session_charges, dependent: :destroy

  # There must be at least one session charge setup for the client
  validates :session_charges, presence: true
  validate :session_charges_must_not_overlap

  # Add a default session_charges record if none exists.
  after_initialize do |client|
    client.session_charges.build(from: Time.zone.today, hourly_charge_rate: 60) if client.session_charges.empty?
  end

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

    if active_session_charge.nil?
      # No record exists yet, so create a new one.
      _build_active_session_charge(rate)
    elsif active_session_charge.hourly_charge_rate != rate
      # Something has changed, so ...
      if active_session_charge.persisted?
        # If this is a persisted (ie existing) session_charge, then amend date period and add the new record.
        active_session_charge.update!(to: Date.today - 1.day)
        _build_active_session_charge(rate)
      else
        # If not yet persisted, then update existing unsaved record.
        active_session_charge.hourly_charge_rate = rate
      end
    end
    rate
  end

  def _build_active_session_charge(rate)
    self.session_charges << SessionCharge.new(from: Date.today, to: nil, hourly_charge_rate: rate)
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
