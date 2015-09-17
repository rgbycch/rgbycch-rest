FactoryGirl.define do
  factory :player_position do
    title   { FFaker::Name.name }
    position_number { 1 }
    url     { FFaker::Internet.http_url }
  end
end
