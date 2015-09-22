require 'spec_helper'

describe PlayerPosition do
  before { @player_position = FactoryGirl.build(:player_position) }

  subject { @player_position }

  it { should respond_to(:title) }
  it { should respond_to(:url) }
  it { should respond_to(:position_number) }
  it { should have_many(:preferred_positions)}

  it { should validate_presence_of :title }
  it { should validate_numericality_of(:position_number).is_greater_than_or_equal_to(0) }

  it { should be_valid }

  describe "#preferred positions association" do

    before do
      @player_position.save
      3.times { FactoryGirl.create :preferred_position, player_position: @player_position }
    end

    it "destroys the associated preferred positions on self destruct" do
      preferred_positions = @player_position.preferred_positions
      @player_position.destroy
      preferred_positions.each do |preferred_position|
        expect(PreferredPosition.find(preferred_position)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

end
