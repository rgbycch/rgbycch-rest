require 'spec_helper'

describe Api::V1::ClubsController, :type => :controller do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      api_authorization_header @user.auth_token
      @club = FactoryGirl.create :club
      get :show, id: @club.id
    end

    it "returns the information about a club in a hash" do
      club_response = json_response
      expect(club_response[:name]).not_to be_nil
      expect(club_response[:url]).not_to be_nil
    end

    it { should respond_with 200 }
  end

end
