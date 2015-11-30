require 'spec_helper'

describe Api::V1::TeamsController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "User requests a team which is not present" do

        before(:each) do
          @team = FactoryGirl.create :team

          get :show, id: @team.id
        end

        it "returns the information about a team in a hash" do
          team_response = json_response[:team]
          expect(team_response[:title]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a team which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          team_response = json_response
          expect(team_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @team = FactoryGirl.create :team
        get :show, id: @team.id
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

      context "when a team is successfully created" do

        before(:each) do
          @team_attributes = FactoryGirl.attributes_for :team
          post :create, { team: @team_attributes }
        end

        it "renders the json representation for the team just created" do
          team_response = json_response[:team]
          expect(team_response[:title]).to eql @team_attributes[:title]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_team_attributes = { url: "http://www.google.com" }
          post :create, { team: @invalid_team_attributes }
        end

        it "renders an errors json" do
          team_response = json_response
          expect(team_response).to have_key(:errors)
        end

        it "renders the json errors on why the team could not be created" do
          team_response = json_response
          expect(team_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @team_attributes = FactoryGirl.attributes_for :team
        post :create, { team: @team_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @team = FactoryGirl.create :team
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @team.id, team: { title: "Updated Team Title" } }
        end

        it "renders the json representation for the updated team" do
          team_response = json_response[:team]
          expect(team_response[:title]).to eql "Updated Team Title"
        end

        it { should respond_with 200 }
      end

      context "adding a player to a team" do

        before(:each) do
          @player = FactoryGirl.create :player
          put :add_player, { user_id: @user.id, team_id: @team.id, id: @player.id }
        end

        it "renders the json representation for the updated team" do
          team_response = json_response[:team]
          expect(team_response[:players].count).to eql 1
        end

        it { should respond_with 200 }

      end

      context "removing a player from a team" do

        before(:each) do
          @player = FactoryGirl.create :player
          put :remove_player, { user_id: @user.id, team_id: @team.id, id: @player.id }
        end

        it "renders the json representation for the updated team" do
          team_response = json_response[:team]
          expect(team_response[:players].count).to eql 0
        end

        it { should respond_with 200 }

      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @team.id, team: { title: nil } }
        end

        it "renders an errors json" do
          team_response = json_response
          expect(team_response).to have_key(:errors)
        end

        it "renders the json errors on why the team could not be updated" do
          team_response = json_response
          expect(team_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @team.id, team: { title: "Updated Team Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @team = FactoryGirl.create :team
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @team.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @team.id }
      end

      it { should respond_with 401 }

    end

  end

end
