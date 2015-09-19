require 'spec_helper'

describe Api::V1::TeamsController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        @team = FactoryGirl.create :team
        get :show, id: @team.id
      end

      it "returns the information about a team in a hash" do
        team_response = json_response
        expect(team_response[:title]).not_to be_nil
      end

      it { should respond_with 200 }
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
          team_response = json_response
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
