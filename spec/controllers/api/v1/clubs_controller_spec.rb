require 'spec_helper'

describe Api::V1::ClubsController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        4.times { FactoryGirl.create :club }
        get :index
      end

      it "returns 4 clubs from the database" do
        expect(json_response.size).to eq(4)
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

      context "User requests a Club which is present" do

        before(:each) do
          @club = FactoryGirl.create :club

          get :show, id: @club.id
        end

        it "returns the information about a Club in a hash" do
          expect(json_response[:title]).not_to be_nil
          expect(json_response[:url]).not_to be_nil
          expect(json_response[:founded]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a Club which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          club_response = json_response
          expect(club_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @club = FactoryGirl.create :club
        get :show, id: @club.id
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

      context "when a Club is successfully created" do

        before(:each) do
          @club_attributes = FactoryGirl.attributes_for :club
          post :create, { club: @club_attributes }
        end

        it "renders the json representation for the club just created" do
          expect(json_response[:title]).to eql @club_attributes[:title]
          expect(json_response[:url]).to eql @club_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_club_attributes = { url: "http://www.google.com" }
          post :create, { club: @invalid_club_attributes }
        end

        it "renders an errors json" do
          club_response = json_response
          expect(club_response).to have_key(:errors)
        end

        it "renders the json errors on why the club could not be created" do
          club_response = json_response
          expect(club_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @club_attributes = FactoryGirl.attributes_for :club
        post :create, { club: @club_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @club = FactoryGirl.create :club
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @club.id, club: { title: "Updated Club Title" } }
        end

        it "renders the json representation for the updated club" do
          expect(json_response[:title]).to eql "Updated Club Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          post :update, { user_id: @user.id, id: @club.id, club: { title: nil } }
        end

        it "renders an errors json" do
          club_response = json_response
          expect(club_response).to have_key(:errors)
        end

        it "renders the json errors on why the club could not be updated" do
          club_response = json_response
          expect(club_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @club.id, club: { title: "Updated Club Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @club = FactoryGirl.create :club
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @club.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @club.id }
      end

      it { should respond_with 401 }

    end

  end

end
