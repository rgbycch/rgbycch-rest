require 'spec_helper'

describe Official, type: :model do
  before { @official = FactoryGirl.build(:official) }

  subject { @official }

  it { should respond_to(:title) }
  it { should respond_to(:url) }

  it { should  }

  context "filtering and searching" do

    before(:each) do
      @official1 = FactoryGirl.create :official, title: "Pierluigi Jones"
      @official2 = FactoryGirl.create :official, title: "Jim Jones"
      @official3 = FactoryGirl.create :official, title: "Lucky White"
      @official4 = FactoryGirl.create :official, title: "Johnny Mac"
    end

    describe ".filter_by_title" do

      context "when a 'Jones' title pattern is sent" do

        it "returns the officials matching" do
          expect(Official.filter_by_title("Jones").sort).to match_array([@official1, @official2])
        end

      end

    end

    describe ".search" do

      context "when an empty hash is sent" do

        it "returns all the officials" do
          expect(Official.search({})).to match_array([@official1, @official2, @official3, @official4])
        end

      end

      context "when official_ids is present" do

        it "returns the venues associated with those ids" do
          search_hash = { official_ids: [@official1.id, @official2.id]}
          expect(Official.search(search_hash)).to match_array([@official1, @official2])
        end

      end

    end

  end

end
