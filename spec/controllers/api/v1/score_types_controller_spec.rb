require 'spec_helper'

describe Api::V1::ScoreTypesController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :score_type}
        get :index
      end

      it "returns 3 ScoreTypes from the database" do
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

      context "User requests a ScoreType which is present" do

        before(:each) do
          @score_type = FactoryGirl.create :score_type

          get :show, id: @score_type.id
        end

        it "returns the information about a ScoreType in a hash" do
          expect(json_response[:title]).not_to be_nil
          expect(json_response[:url]).not_to be_nil
          expect(json_response[:points]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a ScoreType which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          score_type_response = json_response
          expect(score_type_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @score_type = FactoryGirl.create :score_type
        get :show, id: @score_type.id
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

      context "when a ScoreType is successfully created" do

        before(:each) do
          @score_type_attributes = FactoryGirl.attributes_for :score_type
          post :create, { score_type: @score_type_attributes }
        end

        it "renders the json representation for the ScoreType just created" do
          expect(json_response[:title]).to eql @score_type_attributes[:title]
          expect(json_response[:url]).to eql @score_type_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_score_type_attributes = { url: "https://www.bbc.co.uk" }
          post :create, { score_type: @invalid_score_type_attributes }
        end

        it "renders an errors json" do
          score_type_response = json_response
          expect(score_type_response).to have_key(:errors)
        end

        it "renders the json errors on why the ScoreType could not be created" do
          score_type_response = json_response
          expect(score_type_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @score_type_attributes = FactoryGirl.attributes_for :score_type
        post :create, { score_type: @score_type_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @score_type = FactoryGirl.create :score_type
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @score_type.id, score_type: { title: "Updated ScoreType Title" } }
        end

        it "renders the json representation for the updated ScoreType" do
          expect(json_response[:title]).to eql "Updated ScoreType Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @score_type.id, score_type: { title: nil } }
        end

        it "renders an errors json" do
          score_type_response = json_response
          expect(score_type_response).to have_key(:errors)
        end

        it "renders the json errors on why the ScoreType could not be updated" do
          score_type_response = json_response
          expect(score_type_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @score_type.id, score_type: { title: "Updated ScoreType Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @score_type = FactoryGirl.create :score_type
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @score_type.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @score_type.id }
      end

      it { should respond_with 401 }

    end

  end

end
