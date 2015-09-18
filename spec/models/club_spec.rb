require 'spec_helper'

describe Club do
  before { @club = FactoryGirl.build(:club) }

  subject { @club }

  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:founded) }

  it { should validate_presence_of :name }

  it { should be_valid }

end
