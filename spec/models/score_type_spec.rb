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

end
