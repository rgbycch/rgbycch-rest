require 'spec_helper'

describe Role, type: :model do
  before { @role = FactoryGirl.build(:role) }

  subject { @role }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should  }

  it { should be_valid }

  context "filtering and searching" do

    before(:each) do
      @role1 = FactoryGirl.create :role, title: "Manager"
      @role2 = FactoryGirl.create :role, title: "Head Coach"
      @role3 = FactoryGirl.create :role, title: "Water Boy"
      @role4 = FactoryGirl.create :role, title: "Physio"
    end

    describe ".filter_by_title" do

      context "when a 'Coach' title pattern is sent" do

        it "returns the roles matching" do
          expect(Role.filter_by_title("Coach").sort).to match_array([@role2])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the roles" do
          expect(Role.search({})).to match_array([@role1, @role2, @role3, @role4])
        end

      end

      context "when role_ids is present" do

        it "returns the roles associated with those ids" do
          search_hash = { role_ids: [@role1.id, @role2.id]}
          expect(Role.search(search_hash)).to match_array([@role1, @role2])
        end

      end

    end

  end

end
