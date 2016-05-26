FactoryGirl.define do
  factory :short_url do
    user
    long_url {  Faker::Internet.url }
    shorty {  Faker::Internet.url }
  end
end