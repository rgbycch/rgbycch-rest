FactoryGirl.define do
  factory :event_type do
    title { FFaker::Name.name }
    url   { FFaker::Internet.http_url }
  end
end
