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
  it { should have_many(:preferred_positions)}

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  it { should be_valid }

  describe "#preferred positions association" do

    before do
      @player.save
      3.times { FactoryGirl.create :preferred_position, player: @player }
    end

    it "destroys the associated preferred positions on self destruct" do
      preferred_positions = @player.preferred_positions
      @player.destroy
      preferred_positions.each do |preferred_position|
        expect(PreferredPosition.find(preferred_position)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

end
