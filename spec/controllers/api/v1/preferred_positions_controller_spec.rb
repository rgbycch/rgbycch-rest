require 'spec_helper'

describe Api::V1::PreferredPositionsController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "User requests a PreferredPosition which is present" do

        before(:each) do
          @preferred_position = FactoryGirl.create :preferred_position

          get :show, id: @preferred_position.id
        end

        it "returns the information about a PreferredPosition in a hash" do
          expect(json_response[:preference]).not_to be_nil
          expect(json_response[:player][:id]).not_to be_nil
          expect(json_response[:player_position][:id]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a PreferredPosition which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          preferred_position_response = json_response
          expect(preferred_position_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end


    context "User is not logged in" do

      before(:each) do
        @preferred_position = FactoryGirl.create :preferred_position
        get :show, id: @preferred_position.id
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

      context "when a PreferredPosition is successfully created" do

        before(:each) do
          @preferred_position_attributes = FactoryGirl.attributes_for :preferred_position
          post :create, { preferred_position: @preferred_position_attributes }
        end

        it "renders the json representation for the preferred position just created" do
          expect(json_response[:preference]).to eql @preferred_position_attributes[:preference]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_preferred_position_attributes = { url: "https://espn.co.uk" }
          post :create, { preferred_position: @invalid_preferred_position_attributes }
        end

        it "renders an errors json" do
          preferred_position_response = json_response
          expect(preferred_position_response).to have_key(:errors)
        end

        it "renders the json errors on why the preferred position could not be created" do
          preferred_position_response = json_response
          expect(preferred_position_response[:errors][:preference]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @preferred_position_attributes = FactoryGirl.attributes_for :preferred_position
        post :create, { preferred_position: @preferred_position_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @preferred_position = FactoryGirl.create :preferred_position
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @preferred_position.id, preferred_position: { preference: 2 } }
        end

        it "renders the json representation for the updated preferred position" do
          expect(json_response[:preference]).to eql 2
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @preferred_position.id, preferred_position: { preference: -2 } }
        end

        it "renders an errors json" do
          preferred_position_response = json_response
          expect(preferred_position_response).to have_key(:errors)
        end

        it "renders the json errors on why the preferred position could not be updated" do
          preferred_position_response = json_response
          expect(preferred_position_response[:errors][:preference]).to include "must be greater than or equal to 0"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @preferred_position.id, preferred_position: { preference: 2 } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @preferred_position = FactoryGirl.create :preferred_position
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @preferred_position.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @preferred_position.id }
      end

      it { should respond_with 401 }

    end

  end

end
