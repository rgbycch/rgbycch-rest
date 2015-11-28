require 'spec_helper'

describe Api::V1::VenuesController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "User requests a venue which is present" do

        before(:each) do
          @venue = FactoryGirl.create :venue
          get :show, id: @venue.id
        end

        it "returns the information about a venue in a hash" do
          venue_response = json_response[:venue]
          expect(venue_response[:title]).not_to be_nil
          expect(venue_response[:url]).not_to be_nil
          expect(venue_response[:latitude]).not_to be_nil
          expect(venue_response[:longitude]).not_to be_nil
          expect(venue_response[:capacity]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests a venue which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          venue_response = json_response
          expect(venue_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

    end

    context "User is not logged in" do

      before(:each) do
        @venue = FactoryGirl.create :venue
        get :show, id: @venue.id
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

      context "when a venue is successfully created" do

        before(:each) do
          @venue_attributes = FactoryGirl.attributes_for :venue
          post :create, { venue: @venue_attributes }
        end

        it "renders the json representation for the venue just created" do
          venue_response = json_response[:venue]
          expect(venue_response[:title]).to eql @venue_attributes[:title]
          expect(venue_response[:url]).to eql @venue_attributes[:url]
          expect(venue_response[:latitude]).to eql @venue_attributes[:latitude]
          expect(venue_response[:longitude]).to eql @venue_attributes[:longitude]
          expect(venue_response[:capacity]).to eql @venue_attributes[:capacity]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_venue_attributes = { url: "https://www.reddit.com" }
          post :create, { venue: @invalid_venue_attributes }
        end

        it "renders an errors json" do
          venue_response = json_response
          expect(venue_response).to have_key(:errors)
        end

        it "renders the json errors on why the venue could not be created" do
          venue_response = json_response
          expect(venue_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @venue_attributes = FactoryGirl.attributes_for :venue
        post :create, { venue: @venue_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
      @venue = FactoryGirl.create :venue
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @venue.id, venue: { title: "Updated Venue Title" } }
        end

        it "renders the json representation for the updated venue" do
          venues_response = json_response[:venue]
          expect(venues_response[:title]).to eql "Updated Venue Title"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @venue.id, venue: { title: nil } }
        end

        it "renders an errors json" do
          venue_response = json_response
          expect(venue_response).to have_key(:errors)
        end

        it "renders the json errors on why the venue could not be created" do
          venue_response = json_response
          expect(venue_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end

    end

    context "User is not logged in" do

      before(:each) do
        patch :update, { id: @venue.id, venue: { title: "Updated Venue Title" } }
      end

      it { should respond_with 401 }

    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @venue = FactoryGirl.create :venue
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @venue.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @venue.id }
      end

      it { should respond_with 401 }

    end

  end

end
