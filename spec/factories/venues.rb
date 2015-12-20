FactoryGirl.define do
  factory :venue do
    title "Name of My Venue"
    url     { FFaker::Internet.http_url }
    latitude 1.5
    longitude 1.5
    capacity 1
  end
end
