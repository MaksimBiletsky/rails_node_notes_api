require 'rails_helper'

RSpec.describe "ApiLog", type: :request do
  let!(:api_logs) { create_list(:api_log, 10) }

  describe "GET /api_logs" do
    it "returns a list of api_logs" do
      get "/api_logs"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(10)
    end
  end

  describe "GET /api_logs/search" do
    it "returns a list of api_logs that match the search query" do
      ApiLog.last(3).each { |api_log| api_log.update(request_method: "PUT") }
      get "/api_logs/search?query=GET"
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(7)
    end
  end

  after(:each) do
    ApiLog.destroy_all
  end
end
