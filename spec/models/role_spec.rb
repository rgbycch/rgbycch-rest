require 'spec_helper'

describe Role do
  before { @role = FactoryGirl.build(:role) }

  subject { @role }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should validate_presence_of :title }

  it { should be_valid }

end
