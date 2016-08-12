require 'spec_helper'

describe Venue, type: :model do

  before { @venue = FactoryGirl.build(:venue) }

  subject { @venue }

  it { should respond_to(:title) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:capacity) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }

  context "filtering and searching" do

    before(:each) do
      @venue1 = FactoryGirl.create :venue, title: "Venue 1"
      @venue2 = FactoryGirl.create :venue, title: "venue 2"
      @venue3 = FactoryGirl.create :venue, title: "Pitch 3"
      @venue4 = FactoryGirl.create :venue, title: "Training Ground"
    end

    describe ".filter_by_title" do

      context "when a 'Venue' title pattern is sent" do

        it "returns the venues matching" do
          expect(Venue.filter_by_title("Venue").sort).to match_array([@venue1, @venue2])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the venues" do
          expect(Venue.search({})).to match_array([@venue1, @venue2, @venue3, @venue4])
        end

      end

      context "when venue_ids is present" do

        it "returns the venues associated with those ids" do
          search_hash = { venue_ids: [@venue1.id, @venue2.id]}
          expect(Venue.search(search_hash)).to match_array([@venue1, @venue2])
        end

      end

    end

  end

end
