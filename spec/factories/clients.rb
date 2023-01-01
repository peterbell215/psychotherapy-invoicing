# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name      { 'Test Client' }
    address1  { 'The Test Avenue' }
    town      { 'Cambridge' }
    postcode  { 'CB99 1TA' }
  end
end