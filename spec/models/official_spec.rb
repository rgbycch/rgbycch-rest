require 'spec_helper'

describe Official do
  before { @official = FactoryGirl.build(:official) }

  subject { @official }

  it { should respond_to(:title) }
  it { should respond_to(:url) }

  it { should validate_presence_of :title }
end
