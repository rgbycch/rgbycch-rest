require 'spec_helper'

describe Score do
  before { @score = FactoryGirl.build(:score) }

  subject { @score }

  it { should respond_to(:home_score) }
  it { should respond_to(:away_score) }
end
