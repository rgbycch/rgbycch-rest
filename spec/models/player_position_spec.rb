require 'spec_helper'

describe PlayerPosition, type: :model do
  before { @player_position = FactoryGirl.build(:player_position) }

  subject { @player_position }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:position_number) }
  it { should have_many(:preferred_positions)}

  it { should  }
  it { should validate_numericality_of(:position_number).is_greater_than_or_equal_to(0) }

  it { should be_valid }

  describe "#preferred positions association" do

    before do
      @player_position.save
      3.times { FactoryGirl.create :preferred_position, player_position: @player_position }
    end

    it "destroys the associated preferred positions on self destruct" do
      preferred_positions = @player_position.preferred_positions
      @player_position.destroy
      preferred_positions.each do |preferred_position|
        expect(PreferredPosition.find(preferred_position)).to raise_error ActiveRecord::RecordNotFound
      end

    end

  end

  context "filtering and searching" do

    before(:each) do
      @player_position1 = FactoryGirl.create :player_position, title: "Full Back"
      @player_position2 = FactoryGirl.create :player_position, title: "Scrum Half"
      @player_position3 = FactoryGirl.create :player_position, title: "Out Half"
      @player_position4 = FactoryGirl.create :player_position, title: "Blindside Flanker"
    end

    describe ".filter_by_title" do

      context "when a 'Half' title pattern is sent" do

        it "returns the positions matching" do
          expect(PlayerPosition.filter_by_title("Half").sort).to match_array([@player_position2, @player_position3])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the players" do
          expect(PlayerPosition.search({})).to match_array([@player_position1, @player_position2, @player_position3, @player_position4])
        end

      end

      context "when player_position_ids is present" do

        it "returns the PlayerPositions associated with those ids" do
          search_hash = { player_position_ids: [@player_position1.id, @player_position2.id]}
          expect(PlayerPosition.search(search_hash)).to match_array([@player_position1, @player_position2])
        end

      end

    end

  end

end
