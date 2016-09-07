require 'spec_helper'

describe Team, type: :model do
  before { @team = FactoryGirl.build(:team) }

  subject { @team }

  it { should respond_to(:title) }
  it { should respond_to(:club_id) }
  it { should respond_to(:players) }

  it { should  }

  it { should be_valid }

  context "filtering and searching" do

    before(:each) do
      @team1 = FactoryGirl.create :team, title: "Under 16"
      @team2 = FactoryGirl.create :team, title: "Under 21"
      @team3 = FactoryGirl.create :team, title: "Senior"
      @team4 = FactoryGirl.create :team, title: "Junior B"
    end

    describe ".filter_by_title" do

      context "when a 'Under' title pattern is sent" do

        it "returns the teams matching" do
          expect(Team.filter_by_title("Under").sort).to match_array([@team1, @team2])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the teams" do
          expect(Team.search({})).to match_array([@team1, @team2, @team3, @team4])
        end

      end

      context "when team_ids is present" do

        it "returns the teams associated with those ids" do
          search_hash = { team_ids: [@team1.id, @team2.id]}
          expect(Team.search(search_hash)).to match_array([@team1, @team2])
        end

      end

    end

  end

end
