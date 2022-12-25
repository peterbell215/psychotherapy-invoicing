namespace :dev do
  desc "Creates a set of test data using Faker"
  task create_test_data: :environment do
    Faker::Config.locale = 'en-GB'

    10.times do
      postcode = "CB#{Random.rand(1..20)} #{Random.rand(1..20)}#{(0..1).map { (65 + rand(26)).chr }.join}"

      Client.create!(name: Faker::Name.name, address1: Faker::Address.street_address, town: 'Cambridge', postcode: postcode)
    end
  end
end
