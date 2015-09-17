require 'spec_helper'

describe PlayerPosition do
  before { @player_position = FactoryGirl.build(:player_position) }

  subject { @player_position }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:position_number) }

  it { should validate_presence_of :title }
  it { should validate_numericality_of(:position_number).is_greater_than_or_equal_to(0) }

  it { should be_valid }

end
