require 'spec_helper'

describe Api::V1::MatchDayPlayersController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :match_day_player}
        get :index
      end

      it "returns 3 MatchDayPlayers from the database" do
        expect(json_response.size).to eq(3)
      end

      it { should respond_with 200 }
    end

  end

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "User requests a MatchDayPlayer which is present" do

        before(:each) do
          @match_day_player = FactoryGirl.create :match_day_player

          get :show, id: @match_day_player.id
        end

        it "returns the information about a MatchDayPlayer in a hash" do
          expect(json_response[:player]).not_to be_nil
          expect(json_response[:player_position]).not_to be_nil
          expect(json_response[:rating]).not_to be_nil
          expect(json_response[:points]).not_to be_nil
          expect(json_response[:fouls]).not_to be_nil
          expect(json_response[:turnovers_for]).not_to be_nil
          expect(json_response[:turnovers_against]).not_to be_nil
          expect(json_response[:penalties_won]).not_to be_nil
          expect(json_response[:penalties_conceded]).not_to be_nil
          expect(json_response[:yellow_cards]).not_to be_nil
          expect(json_response[:red_cards]).not_to be_nil
          expect(json_response[:carries]).not_to be_nil
          expect(json_response[:yards_carried]).not_to be_nil
          expect(json_response[:forward_passes]).not_to be_nil
          expect(json_response[:successful_lineout_throws]).not_to be_nil
          expect(json_response[:unsuccessful_lineout_throws]).not_to be_nil
          expect(json_response[:scrums_won]).not_to be_nil
          expect(json_response[:scrums_lost]).not_to be_nil
          expect(json_response[:successful_garryowens]).not_to be_nil
          expect(json_response[:unsuccessful_garryowens]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a MatchDayPlayer which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          match_day_player_response = json_response
          expect(match_day_player_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @match_day_player = FactoryGirl.create :match_day_player
        get :show, id: @match_day_player.id
      end

      it { should respond_with 401 }
    end

  end

  describe "POST #create" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when a MatchDayPlayer is successfully created" do

        before(:each) do
          @match_day_player_attributes = FactoryGirl.attributes_for :match_day_player
          post :create, { match_day_player: @match_day_player_attributes }
        end

        it "renders the json representation for the MatchDayPlayer just created" do
          expect(json_response[:player]).to eql @match_day_player_attributes[:player]
          expect(json_response[:player_position]).to eql @match_day_player_attributes[:player_position]
          expect(json_response[:rating]).to eql @match_day_player_attributes[:rating]
          expect(json_response[:points]).to eql @match_day_player_attributes[:points]
          expect(json_response[:fouls]).to eql @match_day_player_attributes[:fouls]
          expect(json_response[:turnovers_for]).to eql @match_day_player_attributes[:turnovers_for]
          expect(json_response[:turnovers_against]).to eql @match_day_player_attributes[:turnovers_against]
          expect(json_response[:penalties_won]).to eql @match_day_player_attributes[:penalties_won]
          expect(json_response[:penalties_conceded]).to eql @match_day_player_attributes[:penalties_conceded]
          expect(json_response[:yellow_cards]).to eql @match_day_player_attributes[:yellow_cards]
          expect(json_response[:red_cards]).to eql @match_day_player_attributes[:red_cards]
          expect(json_response[:carries]).to eql @match_day_player_attributes[:carries]
          expect(json_response[:yards_carried]).to eql @match_day_player_attributes[:yards_carried]
          expect(json_response[:forward_passes]).to eql @match_day_player_attributes[:forward_passes]
          expect(json_response[:successful_lineout_throws]).to eql @match_day_player_attributes[:successful_lineout_throws]
          expect(json_response[:unsuccessful_lineout_throws]).to eql @match_day_player_attributes[:unsuccessful_lineout_throws]
          expect(json_response[:scrums_won]).to eql @match_day_player_attributes[:scrums_won]
          expect(json_response[:scrums_lost]).to eql @match_day_player_attributes[:scrums_lost]
          expect(json_response[:successful_garryowens]).to eql @match_day_player_attributes[:successful_garryowens]
          expect(json_response[:unsuccessful_garryowens]).to eql @match_day_player_attributes[:unsuccessful_garryowens]

        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_match_day_player_attributes = { rating: -1 }
          post :create, { match_day_player: @invalid_match_day_player_attributes }
        end

        it "renders an errors json" do
          match_day_player_response = json_response
          expect(match_day_player_response).to have_key(:errors)
        end

        it "renders the json errors on why the MatchDayPlayer could not be created" do
          match_day_player_response = json_response
          expect(match_day_player_response[:errors][:rating]).to include "must be greater than or equal to 0"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @match_day_player_attributes = FactoryGirl.attributes_for :match_day_player
        post :create, { match_day_player: @match_day_player_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @match_day_player = FactoryGirl.create :match_day_player
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @match_day_player.id, match_day_player: { rating: 10 } }
        end

        it "renders the json representation for the updated MatchDayPlayer" do
          expect(json_response[:rating]).to eql 10
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @match_day_player.id, match_day_player: { rating: -1 } }
        end

        it "renders an errors json" do
          match_day_player_response = json_response
          expect(match_day_player_response).to have_key(:errors)
        end

        it "renders the json errors on why the MatchDayPlayer could not be updated" do
          match_day_player_response = json_response
          expect(match_day_player_response[:errors][:rating]).to include "must be greater than or equal to 0"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @match_day_player.id, match_day_player: { rating: 10 } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @match_day_player = FactoryGirl.create :match_day_player
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @match_day_player.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @match_day_player.id }
      end

      it { should respond_with 401 }

    end

  end

end
