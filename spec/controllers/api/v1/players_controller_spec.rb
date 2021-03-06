require 'spec_helper'

describe Api::V1::PlayersController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :player}
        get :index
      end

      it "returns 3 players from the database" do
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

      context "User requests a Player which is present" do

        before(:each) do
          @player = FactoryGirl.create :player

          get :show, id: @player.id
        end

        it "returns the information about a Player in a hash" do
          expect(json_response[:first_name]).not_to be_nil
          expect(json_response[:last_name]).not_to be_nil
          expect(json_response[:nick_name]).not_to be_nil
          expect(json_response[:dob]).not_to be_nil
          expect(json_response[:email]).not_to be_nil
          expect(json_response[:phone_number]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a Player which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          player_response = json_response
          expect(player_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end


    context "User is not logged in" do

      before(:each) do
        @player = FactoryGirl.create :player
        get :show, id: @player.id
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

      context "when a Player is successfully created" do

        before(:each) do
          @player_attributes = FactoryGirl.attributes_for :player
          post :create, { player: @player_attributes }
        end

        it "renders the json representation for the player just created" do
          expect(json_response[:title]).to eql @player_attributes[:title]
          expect(json_response[:url]).to eql @player_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_player_attributes = { first_name: "Tom" }
          post :create, { player: @invalid_player_attributes }
        end

        it "renders an errors json" do
          player_response = json_response
          expect(player_response).to have_key(:errors)
        end

        it "renders the json errors on why the player could not be created" do
          player_response = json_response
          expect(player_response[:errors][:last_name]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @player_attributes = FactoryGirl.attributes_for :player
        post :create, { player: @player_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @player = FactoryGirl.create :player
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @player.id, player: { first_name: "Updated First Name" } }
        end

        it "renders the json representation for the updated player" do
          expect(json_response[:first_name]).to eql "Updated First Name"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @player.id, player: { last_name: nil } }
        end

        it "renders an errors json" do
          player_response = json_response
          expect(player_response).to have_key(:errors)
        end

        it "renders the json errors on why the player could not be updated" do
          player_response = json_response
          expect(player_response[:errors][:last_name]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @player.id, player: { first_name: "Updated First Name" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @player = FactoryGirl.create :player
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @player.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @player.id }
      end

      it { should respond_with 401 }

    end

  end

end
