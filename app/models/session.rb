# frozen_string_literal: true

# Describes a single session for a client with the therapist.
class Session < ApplicationRecord
  belongs_to :client

  monetize :hourly_charge_pence
end
