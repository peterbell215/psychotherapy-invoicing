# frozen_string_literal: true

FactoryBot.define do
  factory :session_charge do
    from    { Date.new(2022, 10, 1) }
  end
end