require 'spec_helper'

describe ScoreType, type: :model do
  before { @score_type = FactoryGirl.build(:score_type) }

  subject { @score_type }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:points) }

  it { should  }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }

  it { should be_valid }

  context "filtering and searching" do

    before(:each) do
      @score_type1 = FactoryGirl.create :score_type, title: "Conversion"
      @score_type2 = FactoryGirl.create :score_type, title: "Penalty Try"
      @score_type3 = FactoryGirl.create :score_type, title: "Penalty"
      @score_type4 = FactoryGirl.create :score_type, title: "Try"
    end

    describe ".filter_by_title" do

      context "when a 'Penalty' title pattern is sent" do

        it "returns the ScoreTypes matching" do
          expect(ScoreType.filter_by_title("Penalty").sort).to match_array([@score_type2, @score_type3])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the ScoreTypes" do
          expect(ScoreType.search({})).to match_array([@score_type1, @score_type2, @score_type3, @score_type4])
        end

      end

      context "when score_type_ids is present" do

        it "returns the ScoreTypes associated with those ids" do
          search_hash = { score_type_ids: [@score_type1.id, @score_type2.id]}
          expect(ScoreType.search(search_hash)).to match_array([@score_type1, @score_type2])
        end

      end

    end

  end

end
