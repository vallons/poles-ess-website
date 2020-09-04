require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe Admin::ActivitiesController, type: :controller do

    login_admin

    let(:valid_attributes) {
        { :title => "Test title!", :description => "This is a test description" }
    }

    let(:valid_session) { {} }

    describe "GET #index" do
        it "returns a success response" do
            Activity.create! valid_attributes
            get :index, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end
end
