FactoryGirl.define do
  factory :match_day_player do
    player
    player_position
    rating 5
    points 3
    fouls 0
    turnovers_for 0
    turnovers_against 0
    penalties_won 1
    penalties_conceded 0
    yellow_cards 0
    red_cards 0
    carries 12
    yards_carried 100
    forward_passes 0
    successful_lineout_throws 0
    unsuccessful_lineout_throws 0
    scrums_won 0
    scrums_lost 0
    successful_garryowens 0
    unsuccessful_garryowens 0
  end
end
