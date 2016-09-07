require 'spec_helper'

describe MatchState, type: :model do
  before { @match_state = FactoryGirl.build(:match_state) }

  subject { @match_state }

  it { should respond_to(:title) }
  it { should  }

  context "filtering and searching" do

    before(:each) do
      @match_state1 = FactoryGirl.create :match_state, title: "Start"
      @match_state2 = FactoryGirl.create :match_state, title: "starting soon"
      @match_state3 = FactoryGirl.create :match_state, title: "Game Over"
      @match_state4 = FactoryGirl.create :match_state, title: "Half Time"
    end

    describe ".filter_by_title" do

      context "when a 'Start' title pattern is sent" do

        it "returns the match states matching" do
          expect(MatchState.filter_by_title("Start").sort).to match_array([@match_state1, @match_state2])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the match states" do
          expect(MatchState.search({})).to match_array([@match_state1, @match_state2, @match_state3, @match_state4])
        end

      end

      context "when match_state_ids is present" do

        it "returns the match states associated with those ids" do
          search_hash = { match_state_ids: [@match_state1.id, @match_state2.id]}
          expect(MatchState.search(search_hash)).to match_array([@match_state1, @match_state2])
        end

      end

    end

  end

end
