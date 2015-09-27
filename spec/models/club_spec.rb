require 'spec_helper'

describe Club do
  before { @club = FactoryGirl.build(:club) }

  subject { @club }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:founded) }

  it { should have_many(:teams) }

  it { should validate_presence_of :title }

  it { should be_valid }

  describe "#team association" do

    before do
      @club.save
      3.times { FactoryGirl.create :team, club: @club }
    end

    it "destroys the associated teams on self destruct" do
      teams = @club.teams
      @club.destroy
      teams.each do |team|
        expect(Team.find(team.id)).to raise_error ActiveRecord::RecordNotFound
      end

    end

  end

  context "filtering and searching" do

    before(:each) do
      @club1 = FactoryGirl.create :club, title: "Underwoods RFC"
      @club2 = FactoryGirl.create :club, title: "Hilly RFC"
      @club3 = FactoryGirl.create :club, title: "Flat Plains RFC"
      @club4 = FactoryGirl.create :club, title: "Toms Rugby Club"
    end

    describe ".filter_by_title" do

      context "when a 'RFC' title pattern is sent" do

        it "returns the clubs matching" do
          expect(Club.filter_by_title("RFC").sort).to match_array([@club1, @club2, @club3])
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
