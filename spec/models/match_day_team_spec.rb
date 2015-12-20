require 'spec_helper'

describe MatchDayTeam do
  before { @match_day_team = FactoryGirl.build(:match_day_team) }

  subject { @match_day_team }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:match_day_players) }

  it { should validate_presence_of :title }

  it { should be_valid }

  context "filtering and searching" do

    before(:each) do
      @match_day_team1 = FactoryGirl.create :match_day_team, title: "Attacking Team"
      @match_day_team2 = FactoryGirl.create :match_day_team, title: "Defensive Team"
      @match_day_team3 = FactoryGirl.create :match_day_team, title: "Experimental"
    end

    describe ".filter_by_title" do

      context "when a 'Team' title pattern is sent" do

        it "returns the MatchDayTeams matching" do
          expect(MatchDayTeam.filter_by_title("Team").sort).to match_array([@match_day_team1, @match_day_team2])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the teams" do
          expect(MatchDayTeam.search({})).to match_array([@match_day_team1, @match_day_team2, @match_day_team3])
        end

      end

      context "when team_ids is present" do

        it "returns the teams associated with those ids" do
          search_hash = { match_day_team_ids: [@match_day_team1.id, @match_day_team2.id]}
          expect(MatchDayTeam.search(search_hash)).to match_array([@match_day_team1, @match_day_team2])
        end

      end

    end

  end

end
