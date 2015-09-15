require 'spec_helper'

describe Api::V1::EventTypesController, :type => :controller do

  describe "GET #show" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        @event_type = FactoryGirl.create :event_type

        get :show, id: @event_type.id
      end

      it "returns the information about an event type in a hash" do
        event_type_response = json_response
        expect(event_type_response[:title]).not_to be_nil
        expect(event_type_response[:url]).not_to be_nil
      end

      it { should respond_with 200 }
    end


    context "User is not logged in" do

      before(:each) do
        @event_type = FactoryGirl.create :event_type
        get :show, id: @event_type.id
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

      context "when an event type is successfully created" do

        before(:each) do
          @event_type_attributes = FactoryGirl.attributes_for :event_type
          post :create, { event_type: @event_type_attributes }
        end

        it "renders the json representation for the event type just created" do
          event_type_response = json_response
          expect(event_type_response[:title]).to eql @event_type_attributes[:title]
          expect(event_type_response[:url]).to eql @event_type_attributes[:url]
        end

        it { should respond_with 201 }
      end

      context "when is not created" do

        before(:each) do
          @invalid_event_type_attributes = { url: "https://www.github.com" }
          post :create, { event_type: @invalid_event_type_attributes }
        end

        it "renders an errors json" do
          event_type_response = json_response
          expect(event_type_response).to have_key(:errors)
        end

        it "renders the json errors on why the event type could not be created" do
          event_type_response = json_response
          expect(event_type_response[:errors][:title]).to include "can't be blank"
        end

        it { should respond_with 422 }
      end
    end

    context "User is not logged in" do

      before(:each) do
        @event_type_attributes = FactoryGirl.attributes_for :event_type
        post :create, { event_type: @event_type_attributes }
      end

      it { should respond_with 401 }
    end

  end

  describe "DELETE #destroy" do

    before(:each) do
      @event_type = FactoryGirl.create :event_type
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        delete :destroy, { id: @event_type.id }
      end

      it { should respond_with 204 }

    end

    context "User is not logged in" do

      before(:each) do
        delete :destroy, { id: @event_type.id }
      end

      it { should respond_with 401 }

    end

  end

end
