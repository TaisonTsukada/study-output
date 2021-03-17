require 'rails_helper'

RSpec.describe "Dmnotifications", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/dmnotifications/index"
      expect(response).to have_http_status(:success)
    end
  end

end
