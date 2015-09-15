FactoryGirl.define do
  factory :role do
    title { FFaker::Name.name }
    url   { FFaker::Internet.http_url }
  end
end
