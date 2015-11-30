FactoryGirl.define do
  factory :match_day_team do
    title "Starting XV"
    url     { FFaker::Internet.http_url }
  end
end
