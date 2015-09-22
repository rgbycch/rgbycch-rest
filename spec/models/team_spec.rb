require 'spec_helper'

describe Team do
  before { @team = FactoryGirl.build(:team) }

  subject { @team }

  it { should respond_to(:title) }
  it { should respond_to(:club_id) }
  it { should respond_to(:players) }

  it { should validate_presence_of :title }

  it { should be_valid }

  describe ".filter_by_title" do

    before(:each) do
      @team1 = FactoryGirl.create :team, title: "Under 16"
      @team2 = FactoryGirl.create :team, title: "Under 21"
      @team3 = FactoryGirl.create :team, title: "Senior"
      @team4 = FactoryGirl.create :team, title: "Junior B"
    end

    context "when a 'Under' title pattern is sent" do

      it "returns the teams matching" do
        expect(Team.filter_by_title("Under").sort).to match_array([@team1, @team2])
      end

    end

  end

end
