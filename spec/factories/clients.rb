# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name      { 'Test Client' }
    address1  { 'The Test Avenue' }
    town      { 'Cambridge' }
    postcode  { 'CB99 1TA' }

    factory :client_with_session_charges do
      transient do
        gap { 1.day }
      end

      session_charges {
        3.times.each_with_object([]) do |loop, session_charges|
          from = session_charges.empty? ? Date.new(2022, 12, 1) : session_charges.last.to + gap
          to = loop < 2? from + 6.months : nil
          session_charges.push(association(:session_charge, from: from, to: to))
        end
      }
    end
  end
end