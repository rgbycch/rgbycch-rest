require 'spec_helper'

describe MatchDayPlayer do
  before { @match_day_player = FactoryGirl.build(:match_day_player) }

  subject { @match_day_player }

  it { should respond_to(:player) }
  it { should respond_to(:player_position) }
  it { should respond_to(:match_day_team) }
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
  it { should validate_numericality_of(:rating).is_less_than_or_equal_to(100) }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:fouls).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:turnovers_for).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:turnovers_against).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:penalties_won).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:penalties_conceded).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:yellow_cards).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:yellow_cards).is_less_than_or_equal_to(2) }
  it { should validate_numericality_of(:red_cards).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:red_cards).is_less_than_or_equal_to(1) }
  it { should validate_numericality_of(:carries).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:yards_carried).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:forward_passes).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:successful_lineout_throws).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:unsuccessful_lineout_throws).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:scrums_won).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:scrums_lost).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:successful_garryowens).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:unsuccessful_garryowens).is_greater_than_or_equal_to(0) }

  context "filtering and searching" do

    before(:each) do
      @player1 = FactoryGirl.create :player, first_name: "Tom", last_name: "Thumb", nick_name: "Tommy Four Fingers"
      @player2 = FactoryGirl.create :player, first_name: "Dick", last_name: "Turpin", nick_name: "Hatchet"
      @player3 = FactoryGirl.create :player, first_name: "Harry", last_name: "Hill", nick_name: "Hatchet Man"
      @player4 = FactoryGirl.create :player, first_name: "Jimmy", last_name: "Hill", nick_name: "Hatchet Header"

      @match_day_player1 = FactoryGirl.create :match_day_player, player: @player1
      @match_day_player2 = FactoryGirl.create :match_day_player, player: @player2
      @match_day_player3 = FactoryGirl.create :match_day_player, player: @player3
      @match_day_player4 = FactoryGirl.create :match_day_player, player: @player4
    end

    describe ".filter_by_title" do

      context "when a 'Hatchet' title pattern is sent" do

        it "returns the MatchDay players matching" do
          # TODO - Figure out how to delegate to the underlying player
          # expect(MatchDayPlayer.filter_by_title("Hatchet").sort).to match_array([@match_day_player2, @match_day_player3, @match_day_player4])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the MatchDay players" do
          expect(MatchDayPlayer.search({})).to match_array([@match_day_player1, @match_day_player2, @match_day_player3, @match_day_player4])
        end

      end

      context "when match_day_player_ids is present" do

        it "returns the MatchDay players associated with those ids" do
          search_hash = { match_day_player_ids: [@match_day_player1.id, @match_day_player2.id]}
          expect(MatchDayPlayer.search(search_hash)).to match_array([@match_day_player1, @match_day_player2])
        end

      end

    end

  end

end