require 'spec_helper'

describe Role do
  before { @role = FactoryGirl.build(:role) }

  subject { @role }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should validate_presence_of :title }

  it { should be_valid }

  describe ".filter_by_title" do

    before(:each) do
      @role1 = FactoryGirl.create :role, title: "Manager"
      @role2 = FactoryGirl.create :role, title: "Head Coach"
      @role3 = FactoryGirl.create :role, title: "Water Boy"
      @role4 = FactoryGirl.create :role, title: "Physio"
    end

    context "when a 'Coach' title pattern is sent" do

      it "returns the roles matching" do
        expect(Role.filter_by_title("Coach").sort).to match_array([@role2])
      end

    end

  end

end
