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

  describe ".filter_by_name" do

    before(:each) do
      @club1 = FactoryGirl.create :club, name: "Underwoods RFC"
      @club2 = FactoryGirl.create :club, name: "Hilly RFC"
      @club3 = FactoryGirl.create :club, name: "Flat Plains RFC"
      @club4 = FactoryGirl.create :club, name: "Toms Rugby Club"
    end

    context "when a 'RFC' name pattern is sent" do

      it "returns the clubs matching" do
        expect(Club.filter_by_name("RFC").sort).to match_array([@club1, @club2, @club3])
      end

    end

  end

end
