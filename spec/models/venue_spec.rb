require 'spec_helper'

describe Venue do
  before { @venue = FactoryGirl.build(:venue) }

  subject { @venue }

  it { should respond_to(:title) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:capacity) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :latitude }
  it { should validate_presence_of :longitude }

end