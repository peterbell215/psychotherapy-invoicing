# frozen_string_literal: true

namespace :dev do
  desc 'Creates a set of test data using Faker'
  task create_test_data: :environment do
    Faker::Config.locale = 'en-GB'

    Client.destroy_all

    10.times do
      postcode = "CB#{Random.rand(1..20)} #{Random.rand(1..20)}#{(0..1).map { rand(65..(65 + 26)).chr }.join}"
      charge = 10.0 * Random.rand(4..6)

      client = Client.create!(name: Faker::Name.name, address1: Faker::Address.street_address, town: 'Cambridge',
                              postcode: postcode)

      started = Time.zone.today - Random.rand(14..365).days
      start_time = Random.rand(8..19).hours

      SessionCharge.create!(client: client, from: started, hourly_charge_rate: charge)

      (started...Time.zone.today).select { |date| date.wday == started.wday }.each do |session_date|
        Session.create!(client: client, start: session_date + start_time, duration: 60.minutes, hourly_charge: charge)
      end
    end
  end
end
