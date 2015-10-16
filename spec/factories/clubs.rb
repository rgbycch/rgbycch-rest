FactoryGirl.define do
  factory :club do
    title { FFaker::Name.name }
    url { FFaker::Internet.http_url }
    founded { "2015-09-17 10:24:05" }
  end
end