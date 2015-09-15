require 'spec_helper'

describe EventType do
  before { @event_type = FactoryGirl.build(:event_type) }

  subject { @event_type }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should validate_presence_of :title }

  it { should be_valid }

end
