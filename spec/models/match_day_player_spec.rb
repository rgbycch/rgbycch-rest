require 'spec_helper'

describe MatchDayPlayer do
  before { @match_day_player = FactoryGirl.build(:match_day_player) }

  subject { @match_day_player }

  it { should respond_to(:player) }
  it { should respond_to(:player_position) }
  it { should respond_to(:rating) }
  it { should respond_to(:points) }
  it { should respond_to(:fouls) }
  it { should respond_to(:turnovers_for) }
  it { should respond_to(:turnovers_against) }
  it { should respond_to(:penalties_won) }
  it { should respond_to(:penalties_conceded) }
  it { should respond_to(:yellow_cards) }
  it { should respond_to(:red_cards) }
  it { should respond_to(:carries) }
  it { should respond_to(:yards_carried) }
  it { should respond_to(:forward_passes) }
  it { should respond_to(:successful_lineout_throws) }
  it { should respond_to(:unsuccessful_lineout_throws) }
  it { should respond_to(:scrums_won) }
  it { should respond_to(:scrums_lost) }
  it { should respond_to(:successful_garryowens) }
  it { should respond_to(:unsuccessful_garryowens) }

  it { should validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:fouls).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:turnovers_for).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:turnovers_against).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:penalties_won).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:penalties_conceded).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:yellow_cards).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:red_cards).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:carries).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:yards_carried).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:forward_passes).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:successful_lineout_throws).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:unsuccessful_lineout_throws).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:scrums_won).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:scrums_lost).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:successful_garryowens).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:unsuccessful_garryowens).is_greater_than_or_equal_to(0) }

end