require 'spec_helper'

describe Api::V1::RolesController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        @role = FactoryGirl.create :role

        get :show, id: @role.id
      end

      it "returns the information about an role in a hash" do
        role_response = json_response
        expect(role_response[:title]).not_to be_nil
        expect(role_response[:url]).not_to be_nil
      end

      it { should respond_with 200 }
    end


    context "User is not logged in" do

      before(:each) do
        @role = FactoryGirl.create :role
        get :show, id: @role.id
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

      context "when an role is successfully created" do

        before(:each) do
          @role_attributes = FactoryGirl.attributes_for :role
          post :create, { role: @role_attributes }
        end

        it "renders the json representation for the role just created" do
          role_response = json_response
          expect(role_response[:title]).to eql @role_attributes[:title]
          expect(role_response[:url]).to eql @role_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_role_attributes = { url: "https://www.reddit.com" }
          post :create, { role: @invalid_role_attributes }
        end

        it "renders an errors json" do
          role_response = json_response
          expect(role_response).to have_key(:errors)
        end

        it "renders the json errors on why the role could not be created" do
          role_response = json_response
          expect(role_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @role_attributes = FactoryGirl.attributes_for :role
        post :create, { role: @role_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @role = FactoryGirl.create :role
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @role.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @role.id }
      end

      it { should respond_with 401 }

    end

  end

end
