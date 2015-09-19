FactoryGirl.define do
  factory :team do
    title { FFaker::Name.name }
    club_id "1"
  end
end
