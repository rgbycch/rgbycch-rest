require 'spec_helper'

describe Api::V1::MatchDayTeamsController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :match_day_team}
        get :index
      end

      it "returns 3 MatchDayTeams from the database" do
        match_day_team_response = json_response[:match_day_teams]
        expect(match_day_team_response.size).to eq(3)
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

      context "User requests a MatchDay team which is not present" do

        before(:each) do
          @match_day_team = FactoryGirl.create :match_day_team
          get :show, id: @match_day_team.id
        end

        it "returns the information about a MatchDay team in a hash" do
          match_day_team_response = json_response[:match_day_team]
          expect(match_day_team_response[:title]).not_to be_nil
          expect(match_day_team_response[:url]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a MatchDay team which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          match_day_team_response = json_response
          expect(match_day_team_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @match_day_team = FactoryGirl.create :match_day_team
        get :show, id: @match_day_team.id
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

      context "when a MatchDay team is successfully created" do

        before(:each) do
          @match_day_team_attributes = FactoryGirl.attributes_for :match_day_team
          post :create, { match_day_team: @match_day_team_attributes }
        end

        it "renders the json representation for the team just created" do
          match_day_team_response = json_response[:match_day_team]
          expect(match_day_team_response[:title]).to eql @match_day_team_attributes[:title]
          expect(match_day_team_response[:url]).to eql @match_day_team_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_match_day_team_attributes = { url: "http://www.google.com" }
          post :create, { match_day_team: @invalid_match_day_team_attributes }
        end

        it "renders an errors json" do
          match_day_team_response = json_response
          expect(match_day_team_response).to have_key(:errors)
        end

        it "renders the json errors on why the team could not be created" do
          match_day_team_response = json_response
          expect(match_day_team_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @match_day_team_attributes = FactoryGirl.attributes_for :match_day_team
        post :create, { match_day_team: @match_day_team_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @match_day_team = FactoryGirl.create :match_day_team
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @match_day_team.id, match_day_team: { title: "Updated MatchDay Team Title" } }
        end

        it "renders the json representation for the updated MatchDay team" do
          match_day_team_response = json_response[:match_day_team]
          expect(match_day_team_response[:title]).to eql "Updated MatchDay Team Title"
        end

        it { should respond_with 200 }
      end

      context "adding a MatchDay player to a MatchDay team" do

        before(:each) do
          @match_day_player = FactoryGirl.create :match_day_player
          put :add_match_day_player, { user_id: @user.id, match_day_team_id: @match_day_team.id, id: @match_day_player.id }
        end

        it "renders the json representation for the updated MatchDay team" do
          match_day_team_response = json_response[:match_day_team]
          expect(match_day_team_response[:match_day_players].count).to eql 1
        end

        it { should respond_with 200 }

      end

      context "removing a MatchDay player from a MatchDay team" do

        before(:each) do
          @match_day_player = FactoryGirl.create :match_day_player
          put :remove_match_day_player, { user_id: @user.id, match_day_team_id: @match_day_team.id, id: @match_day_player.id }
        end

        it "renders the json representation for the updated MatchDay team" do
          match_day_team_response = json_response[:match_day_team]
          expect(match_day_team_response[:match_day_players].count).to eql 0
        end

        it { should respond_with 200 }

      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @match_day_team.id, match_day_team: { title: nil } }
        end

        it "renders an errors json" do
          match_day_team_response = json_response
          expect(match_day_team_response).to have_key(:errors)
        end

        it "renders the json errors on why the team could not be updated" do
          match_day_team_response = json_response
          expect(match_day_team_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @match_day_team.id, match_day_team: { title: "Updated MatchDay Team Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @match_day_team = FactoryGirl.create :match_day_team
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @match_day_team.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @match_day_team.id }
      end

      it { should respond_with 401 }

    end

  end

end
