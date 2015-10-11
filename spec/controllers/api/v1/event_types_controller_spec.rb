require 'spec_helper'

describe Api::V1::EventTypesController, :type => :controller do

  describe "GET #index" do

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
        3.times { FactoryGirl.create :event_type }
        get :index
      end

      it "returns 3 event_types from the database" do
        event_types_response = json_response[:event_types]
        expect(event_types_response.size).to eq(3)
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

      context "User requests an event type which is present" do

        before(:each) do
          @event_type = FactoryGirl.create :event_type

          get :show, id: @event_type.id
        end

        it "returns the information about an event type in a hash" do
          event_type_response = json_response[:event_type]
          expect(event_type_response[:title]).not_to be_nil
          expect(event_type_response[:url]).not_to be_nil
        end

        it { should respond_with 200 }

      end

      context "User requests an event type which is not present" do

        before(:each) do
          get :show, id: "zzz"
        end

        it "returns an error to the api client" do
          event_type_response = json_response
          expect(event_type_response).to have_key(:error)
        end

        it { should respond_with 404 }

      end

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
          event_type_response = json_response[:event_type]
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

  describe "PUT/PATCH #update" do

    before(:each) do
      @event_type = FactoryGirl.create :event_type
    end

    context "User is logged in" do

      before(:each) do
        @user = FactoryGirl.create :user
        api_authorization_header @user.auth_token
      end

      context "when is successfully updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @event_type.id, event_type: { title: "Updated Event Type Name" } }
        end

        it "renders the json representation for the updated event type" do
          event_type_response = json_response[:event_type]
          expect(event_type_response[:title]).to eql "Updated Event Type Name"
        end

        it { should respond_with 200 }
      end

      context "when is not updated" do

        before(:each) do
          patch :update, { user_id: @user.id, id: @event_type.id, event_type: { title: nil } }
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
        patch :update, { id: @event_type.id, event_type: { title: "Updated Event Type Name" } }
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
