require 'spec_helper'

describe Team do
  before { @team = FactoryGirl.build(:team) }

  subject { @team }

  it { should respond_to(:title) }

  it { should validate_presence_of :title }
  it { should belong_to :club }

  it { should be_valid }

end
