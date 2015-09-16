require 'spec_helper'

describe Api::V1::ScoreTypesController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        @score_type = FactoryGirl.create :score_type

        get :show, id: @score_type.id
      end

      it "returns the information about a score type in a hash" do
        score_type_response = json_response
        expect(score_type_response[:title]).not_to be_nil
        expect(score_type_response[:url]).not_to be_nil
        expect(score_type_response[:points]).not_to be_nil
      end

      it { should respond_with 200 }
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

      context "when a score type is successfully created" do

        before(:each) do
          @score_type_attributes = FactoryGirl.attributes_for :score_type
          post :create, { score_type: @score_type_attributes }
        end

        it "renders the json representation for the score type just created" do
          score_type_response = json_response
          expect(score_type_response[:title]).to eql @score_type_attributes[:title]
          expect(score_type_response[:url]).to eql @score_type_attributes[:url]
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

        it "renders the json errors on why the score type could not be created" do
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
