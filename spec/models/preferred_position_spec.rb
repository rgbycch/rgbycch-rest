require 'spec_helper'

describe PreferredPosition do
  before { @preferred_position = FactoryGirl.build(:preferred_position) }

  subject { @preferred_position }

  it { should respond_to(:preference) }
  it { should respond_to(:player) }
  it { should respond_to(:player_position) }

  it { should validate_presence_of :preference }
  it { should validate_numericality_of(:preference).is_greater_than_or_equal_to(0) }

  it { should be_valid }

end
