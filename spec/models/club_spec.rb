require 'spec_helper'

describe Club do
  before { @club = FactoryGirl.build(:club) }

  subject { @club }

  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:founded) }

  it { should have_many(:teams) }

  it { should validate_presence_of :name }

  it { should be_valid }

  context "filtering and searching" do

    before(:each) do
      @club1 = FactoryGirl.create :club, name: "Underwoods RFC"
      @club2 = FactoryGirl.create :club, name: "Hilly RFC"
      @club3 = FactoryGirl.create :club, name: "Flat Plains RFC"
      @club4 = FactoryGirl.create :club, name: "Toms Rugby Club"
    end

    describe ".filter_by_name" do

      context "when a 'RFC' name pattern is sent" do

        it "returns the clubs matching" do
          expect(Club.filter_by_name("RFC").sort).to match_array([@club1, @club2, @club3])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the clubs" do
          expect(Club.search({})).to match_array([@club1, @club2, @club3, @club4])
        end

      end

      context "when product_ids is present" do

        it "returns the clubs associated with those ids" do
          search_hash = { club_ids: [@club1.id, @club2.id]}
          expect(Club.search(search_hash)).to match_array([@club1, @club2])
        end

      end

    end

  end

end
