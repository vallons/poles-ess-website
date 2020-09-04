require 'rails_helper'

RSpec.describe HomeController, type: :controller do

    let(:valid_attributes) {
        { :title => "Test title!", :description => "This is a test description" }
    }

    let(:valid_session) { {} }

    describe "GET #index" do
        it "returns a success response" do
            get :index, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end
end
