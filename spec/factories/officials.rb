FactoryGirl.define do
  factory :official do
    title "Mr Referee"
    url     { FFaker::Internet.http_url }
  end
end
