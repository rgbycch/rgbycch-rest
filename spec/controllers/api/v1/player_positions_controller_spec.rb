require 'spec_helper'

describe Api::V1::PlayerPositionsController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :player_position }
        get :index
      end

      it "returns 3 PlayerPositions from the database" do
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

      context "User requests a PlayerPosition which is present" do

        before(:each) do
          @player_position = FactoryGirl.create :player_position

          get :show, id: @player_position.id
        end

        it "returns the information about a PlayerPosition in a hash" do
          expect(json_response[:title]).not_to be_nil
          expect(json_response[:url]).not_to be_nil
          expect(json_response[:position_number]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a PlayerPosition which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          player_position_response = json_response
          expect(player_position_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end


    context "User is not logged in" do

      before(:each) do
        @player_position = FactoryGirl.create :player_position
        get :show, id: @player_position.id
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

      context "when a PlayerPosition is successfully created" do

        before(:each) do
          @player_position_attributes = FactoryGirl.attributes_for :player_position
          post :create, { player_position: @player_position_attributes }
        end

        it "renders the json representation for the PlayerPosition just created" do
          expect(json_response[:title]).to eql @player_position_attributes[:title]
          expect(json_response[:url]).to eql @player_position_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_player_position_attributes = { url: "https://espn.co.uk" }
          post :create, { player_position: @invalid_player_position_attributes }
        end

        it "renders an errors json" do
          player_position_response = json_response
          expect(player_position_response).to have_key(:errors)
        end

        it "renders the json errors on why the PlayerPosition could not be created" do
          player_position_response = json_response
          expect(player_position_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @player_position_attributes = FactoryGirl.attributes_for :player_position
        post :create, { player_position: @player_position_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @player_position = FactoryGirl.create :player_position
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @player_position.id, player_position: { title: "Updated PlayerPosition Title" } }
        end

        it "renders the json representation for the updated PlayerPosition" do
          expect(json_response[:title]).to eql "Updated PlayerPosition Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @player_position.id, player_position: { title: nil } }
        end

        it "renders an errors json" do
          player_position_response = json_response
          expect(player_position_response).to have_key(:errors)
        end

        it "renders the json errors on why the PlayerPosition could not be updated" do
          player_position_response = json_response
          expect(player_position_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @player_position.id, player_position: { title: "Updated PlayerPosition Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @player_position = FactoryGirl.create :player_position
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @player_position.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @player_position.id }
      end

      it { should respond_with 401 }

    end

  end

end
