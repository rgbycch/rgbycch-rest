require 'spec_helper'

describe Api::V1::PlayerStatesController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :player_state}
        get :index
      end

      it "returns 3 player states from the database" do
        player_state_response = json_response[:player_states]
        expect(player_state_response.size).to eq(3)
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

      context "User requests a player state which is present" do

        before(:each) do
          @player_state = FactoryGirl.create :player_state

          get :show, id: @player_state.id
        end

        it "returns the information about a player state in a hash" do
          player_state_response = json_response[:player_state]
          expect(player_state_response[:title]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a player state which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          player_state_response = json_response
          expect(player_state_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @player_state = FactoryGirl.create :player_state
        get :show, id: @player_state.id
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

      context "when a player state is successfully created" do

        before(:each) do
          @player_state_attributes = FactoryGirl.attributes_for :player_state
          post :create, { player_state: @player_state_attributes }
        end

        it "renders the json representation for the player state just created" do
          player_state_response = json_response[:player_state]
          expect(player_state_response[:title]).to eql @player_state_attributes[:title]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_player_state_attributes = { url: "https://www.reddit.com" }
          post :create, { player_state: @invalid_player_state_attributes }
        end

        it "renders an errors json" do
          player_state_response = json_response
          expect(player_state_response).to have_key(:errors)
        end

        it "renders the json errors on why the player state could not be created" do
          player_state_response = json_response
          expect(player_state_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @player_state_attributes = FactoryGirl.attributes_for :player_state
        post :create, { player_state: @player_state_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @player_state = FactoryGirl.create :player_state
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @player_state.id, player_state: { title: "Updated Match State Title" } }
        end

        it "renders the json representation for the updated player state" do
          player_state_response = json_response[:player_state]
          expect(player_state_response[:title]).to eql "Updated Match State Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @player_state.id, player_state: { title: nil } }
        end

        it "renders an errors json" do
          player_state_response = json_response
          expect(player_state_response).to have_key(:errors)
        end

        it "renders the json errors on why the player state could not be updated" do
          player_state_response = json_response
          expect(player_state_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @player_state.id, player_state: { title: "Updated Match State Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @player_state = FactoryGirl.create :player_state
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @player_state.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @player_state.id }
      end

      it { should respond_with 401 }

    end

  end

end
