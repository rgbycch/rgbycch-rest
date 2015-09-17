require 'spec_helper'

describe Api::V1::PlayerPositionsController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        @player_position = FactoryGirl.create :player_position

        get :show, id: @player_position.id
      end

      it "returns the information about a player position in a hash" do
        player_position_response = json_response
        expect(player_position_response[:title]).not_to be_nil
        expect(player_position_response[:url]).not_to be_nil
        expect(player_position_response[:position_number]).not_to be_nil
      end

      it { should respond_with 200 }
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

      context "when a player position is successfully created" do

        before(:each) do
          @player_position_attributes = FactoryGirl.attributes_for :player_position
          post :create, { player_position: @player_position_attributes }
        end

        it "renders the json representation for the player position just created" do
          player_position_response = json_response
          expect(player_position_response[:title]).to eql @player_position_attributes[:title]
          expect(player_position_response[:url]).to eql @player_position_attributes[:url]
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

        it "renders the json errors on why the player position could not be created" do
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
