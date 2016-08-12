require 'spec_helper'

describe PlayerState, type: :model do
  before { @player_state = FactoryGirl.build(:player_state) }

  subject { @player_state }

  it { should respond_to(:title) }
  it { should  }

  context "filtering and searching" do

    before(:each) do
      @player_state1 = FactoryGirl.create :player_state, title: "Active"
      @player_state2 = FactoryGirl.create :player_state, title: "Suspended"
      @player_state3 = FactoryGirl.create :player_state, title: "Retired"
      @player_state4 = FactoryGirl.create :player_state, title: "Ineligible"
    end

    describe ".filter_by_title" do

      context "when a 'Active' title pattern is sent" do

        it "returns the match states matching" do
          expect(PlayerState.filter_by_title("Active").sort).to match_array([@player_state1])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the match states" do
          expect(PlayerState.search({})).to match_array([@player_state1, @player_state2, @player_state3, @player_state4])
        end

      end

      context "when player_state_ids is present" do

        it "returns the match states associated with those ids" do
          search_hash = { player_state_ids: [@player_state1.id, @player_state2.id]}
          expect(PlayerState.search(search_hash)).to match_array([@player_state1, @player_state2])
        end

      end

    end

  end

end
