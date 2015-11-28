require 'spec_helper'

describe MatchState do
  before { @match_state = FactoryGirl.build(:match_state) }

  subject { @match_state }

  it { should respond_to(:title) }
  it { should validate_presence_of :title }

end
