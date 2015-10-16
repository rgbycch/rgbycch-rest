FactoryGirl.define do
  factory :score_type do
    title   { FFaker::Name.name }
    points  { 5 }
    url     { FFaker::Internet.http_url }
  end
end
