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

      it "returns 3 MatchDay players from the database" do
        match_day_players_response = json_response[:match_day_players]
        expect(match_day_players_response.size).to eq(3)
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

      context "User requests a MatchDay player which is present" do

        before(:each) do
          @match_day_player = FactoryGirl.create :match_day_player

          get :show, id: @match_day_player.id
        end

        it "returns the information about a MatchDay player in a hash" do
          match_day_player_response = json_response[:match_day_player]
          expect(match_day_player_response[:player]).not_to be_nil
          expect(match_day_player_response[:player_position]).not_to be_nil
          expect(match_day_player_response[:rating]).not_to be_nil
          expect(match_day_player_response[:points]).not_to be_nil
          expect(match_day_player_response[:fouls]).not_to be_nil
          expect(match_day_player_response[:turnovers_for]).not_to be_nil
          expect(match_day_player_response[:turnovers_against]).not_to be_nil
          expect(match_day_player_response[:penalties_won]).not_to be_nil
          expect(match_day_player_response[:penalties_conceded]).not_to be_nil
          expect(match_day_player_response[:yellow_cards]).not_to be_nil
          expect(match_day_player_response[:red_cards]).not_to be_nil
          expect(match_day_player_response[:carries]).not_to be_nil
          expect(match_day_player_response[:yards_carried]).not_to be_nil
          expect(match_day_player_response[:forward_passes]).not_to be_nil
          expect(match_day_player_response[:successful_lineout_throws]).not_to be_nil
          expect(match_day_player_response[:unsuccessful_lineout_throws]).not_to be_nil
          expect(match_day_player_response[:scrums_won]).not_to be_nil
          expect(match_day_player_response[:scrums_lost]).not_to be_nil
          expect(match_day_player_response[:successful_garryowens]).not_to be_nil
          expect(match_day_player_response[:unsuccessful_garryowens]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a MatchDay player which is not present" do

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

      context "when a MatchDay player is successfully created" do

        before(:each) do
          @match_day_player_attributes = FactoryGirl.attributes_for :match_day_player
          post :create, { match_day_player: @match_day_player_attributes }
        end

        it "renders the json representation for the MatchDay player just created" do
          match_day_player_response = json_response[:match_day_player]
          expect(match_day_player_response[:player]).to eql @match_day_player_attributes[:player]
          expect(match_day_player_response[:player_position]).to eql @match_day_player_attributes[:player_position]
          expect(match_day_player_response[:rating]).to eql @match_day_player_attributes[:rating]
          expect(match_day_player_response[:points]).to eql @match_day_player_attributes[:points]
          expect(match_day_player_response[:fouls]).to eql @match_day_player_attributes[:fouls]
          expect(match_day_player_response[:turnovers_for]).to eql @match_day_player_attributes[:turnovers_for]
          expect(match_day_player_response[:turnovers_against]).to eql @match_day_player_attributes[:turnovers_against]
          expect(match_day_player_response[:penalties_won]).to eql @match_day_player_attributes[:penalties_won]
          expect(match_day_player_response[:penalties_conceded]).to eql @match_day_player_attributes[:penalties_conceded]
          expect(match_day_player_response[:yellow_cards]).to eql @match_day_player_attributes[:yellow_cards]
          expect(match_day_player_response[:red_cards]).to eql @match_day_player_attributes[:red_cards]
          expect(match_day_player_response[:carries]).to eql @match_day_player_attributes[:carries]
          expect(match_day_player_response[:yards_carried]).to eql @match_day_player_attributes[:yards_carried]
          expect(match_day_player_response[:forward_passes]).to eql @match_day_player_attributes[:forward_passes]
          expect(match_day_player_response[:successful_lineout_throws]).to eql @match_day_player_attributes[:successful_lineout_throws]
          expect(match_day_player_response[:unsuccessful_lineout_throws]).to eql @match_day_player_attributes[:unsuccessful_lineout_throws]
          expect(match_day_player_response[:scrums_won]).to eql @match_day_player_attributes[:scrums_won]
          expect(match_day_player_response[:scrums_lost]).to eql @match_day_player_attributes[:scrums_lost]
          expect(match_day_player_response[:successful_garryowens]).to eql @match_day_player_attributes[:successful_garryowens]
          expect(match_day_player_response[:unsuccessful_garryowens]).to eql @match_day_player_attributes[:unsuccessful_garryowens]

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

        it "renders the json errors on why the MatchDay player could not be created" do
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

        it "renders the json representation for the updated MatchDay player" do
          match_day_player_response = json_response[:match_day_player]
          expect(match_day_player_response[:rating]).to eql 10
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

        it "renders the json errors on why the MatchDay player could not be updated" do
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
