require 'spec_helper'

describe Team do
  before { @team = FactoryGirl.build(:team) }

  subject { @team }

  it { should respond_to(:title) }
  it { should respond_to(:club_id) }
  it { should respond_to(:players) }

  it { should validate_presence_of :title }

  it { should be_valid }

end
