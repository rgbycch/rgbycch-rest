require 'spec_helper'

describe Api::V1::RolesController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :role }
        get :index
      end

      it "returns 3 roles from the database" do
        roles_response = json_response[:roles]
        expect(roles_response.size).to eq(3)
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

      context "User requests a Role which is present" do

        before(:each) do
          @role = FactoryGirl.create :role

          get :show, id: @role.id
        end

        it "returns the information about a Role in a hash" do
          role_response = json_response[:role]
          expect(role_response[:title]).not_to be_nil
          expect(role_response[:url]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a Role which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          role_response = json_response
          expect(role_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

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

      context "when a Role is successfully created" do

        before(:each) do
          @role_attributes = FactoryGirl.attributes_for :role
          post :create, { role: @role_attributes }
        end

        it "renders the json representation for the role just created" do
          role_response = json_response[:role]
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

  describe "PUT/PATCH #update" do

    before(:each) do
      @role = FactoryGirl.create :role
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @role.id, role: { title: "Updated Role Title" } }
        end

        it "renders the json representation for the updated role" do
          roles_response = json_response[:role]
          expect(roles_response[:title]).to eql "Updated Role Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @role.id, role: { title: nil } }
        end

        it "renders an errors json" do
          role_response = json_response
          expect(role_response).to have_key(:errors)
        end

        it "renders the json errors on why the role could not be updated" do
          role_response = json_response
          expect(role_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @role.id, role: { title: "Updated Role Title" } }
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
