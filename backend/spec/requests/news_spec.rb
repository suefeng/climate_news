require 'rails_helper'

RSpec.describe "/news", type: :request do
  let!(:news) {
    create_list(:news, 2)
  }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_news_index_url, as: :json
      expect(response).to be_successful
    end

    it "renders 5 news articles" do
      get api_v1_news_index_url, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
    end

    it "renders a list of news" do
      get api_v1_news_index_url, as: :json
      json_response = JSON.parse(response.body)
      expect(json_response[0]["title"]).to be_present
      expect(json_response[0]["url"]).to be_present
      expect(json_response[0]["summary"]).to be_present
      expect(json_response[0]["published_at"]).to be_present
      expect(json_response[0]["site_name"]).to be_present
      expect(json_response[0]["images"]).to be_present
      expect(json_response[0]["images"].length).to eq(2)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_news_url(news.first.id), as: :json
      expect(response).to be_successful
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested news" do
      expect {
        delete api_v1_news_url(news.first.id), as: :json
      }.to change(News, :count).by(-1)
    end
  end
end
