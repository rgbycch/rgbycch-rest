require 'spec_helper'

describe Player do
  before { @player = FactoryGirl.build(:player) }

  subject { @player }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:nick_name) }
  it { should respond_to(:dob) }
  it { should respond_to(:email) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:teams) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  it { should be_valid }

end
