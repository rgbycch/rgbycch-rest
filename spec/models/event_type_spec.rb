require 'spec_helper'

describe EventType do
  before { @event_type = FactoryGirl.build(:event_type) }

  subject { @event_type }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should validate_presence_of :title }

  it { should be_valid }

  describe ".filter_by_title" do

    before(:each) do
      @event_type1 = FactoryGirl.create :event_type, title: "Foul - Penalty"
      @event_type2 = FactoryGirl.create :event_type, title: "Foul - Free"
      @event_type3 = FactoryGirl.create :event_type, title: "Sent Off"
      @event_type4 = FactoryGirl.create :event_type, title: "Knock On"
    end

    context "when a 'Foul' title pattern is sent" do

      it "returns the event types matching" do
        expect(EventType.filter_by_title("Foul").sort).to match_array([@event_type1, @event_type2])
      end

    end

  end

end
