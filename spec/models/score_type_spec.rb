require 'spec_helper'

describe ScoreType do
  before { @score_type = FactoryGirl.build(:score_type) }

  subject { @score_type }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:points) }

  it { should validate_presence_of :title }
  it { should validate_numericality_of(:points).is_greater_than_or_equal_to(0) }

  it { should be_valid }

  describe ".filter_by_title" do

    before(:each) do
      @score_type1 = FactoryGirl.create :score_type, title: "Conversion"
      @score_type2 = FactoryGirl.create :score_type, title: "Penalty Try"
      @score_type3 = FactoryGirl.create :score_type, title: "Penalty"
      @score_type4 = FactoryGirl.create :score_type, title: "Try"
    end

    context "when a 'Penalty' title pattern is sent" do

      it "returns the score types matching" do
        expect(ScoreType.filter_by_title("Penalty").sort).to match_array([@score_type2, @score_type3])
      end

    end

  end

end
