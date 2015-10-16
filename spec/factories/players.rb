FactoryGirl.define do
  factory :player do
    first_name { FFaker::Name.name }
    last_name { FFaker::Name.name }
    nick_name { FFaker::Name.name }
    dob { "2015-09-17 10:24:05" }
    email { FFaker::Internet.email }
    phone_number { "123456789" }
  end
end
