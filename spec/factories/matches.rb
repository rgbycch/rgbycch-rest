FactoryGirl.define do
  factory :match do
    home_match_day_team_id 1
    away_match_day_team_id 1
    kick_off_date "2015-12-20 15:51:54"
    venue nil
    referee_id 1
    match_state_id 1
  end
end
