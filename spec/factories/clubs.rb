FactoryGirl.define do
  factory :club do
    name { FFaker::Name.name }
    url { FFaker::Internet.http_url }
  end
end