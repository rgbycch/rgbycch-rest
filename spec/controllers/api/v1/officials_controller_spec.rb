require 'spec_helper'

describe Api::V1::OfficialsController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :official}
        get :index
      end

      it "returns 3 officials from the database" do
        official_response = json_response[:officials]
        expect(official_response.size).to eq(3)
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

      context "User requests an Official which is present" do

        before(:each) do
          @official = FactoryGirl.create :official

          get :show, id: @official.id
        end

        it "returns the information about an Official in a hash" do
          official_response = json_response[:official]
          expect(official_response[:title]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests an Official which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          official_response = json_response
          expect(official_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @official = FactoryGirl.create :official
        get :show, id: @official.id
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

      context "when an Official is successfully created" do

        before(:each) do
          @official_attributes = FactoryGirl.attributes_for :official
          post :create, { official: @official_attributes }
        end

        it "renders the json representation for the official just created" do
          official_response = json_response[:official]
          expect(official_response[:title]).to eql @official_attributes[:title]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_official_attributes = { url: "https://www.reddit.com" }
          post :create, { official: @invalid_official_attributes }
        end

        it "renders an errors json" do
          official_response = json_response
          expect(official_response).to have_key(:errors)
        end

        it "renders the json errors on why the official could not be created" do
          official_response = json_response
          expect(official_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @official_attributes = FactoryGirl.attributes_for :official
        post :create, { official: @official_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @official = FactoryGirl.create :official
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @official.id, official: { title: "Updated Official Title" } }
        end

        it "renders the json representation for the updated official" do
          official_response = json_response[:official]
          expect(official_response[:title]).to eql "Updated Official Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @official.id, official: { title: nil } }
        end

        it "renders an errors json" do
          official_response = json_response
          expect(official_response).to have_key(:errors)
        end

        it "renders the json errors on why the official could not be updated" do
          official_response = json_response
          expect(official_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @official.id, official: { title: "Updated Official Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @official = FactoryGirl.create :official
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @official.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @official.id }
      end

      it { should respond_with 401 }

    end

  end

end
