require 'rails_helper'

RSpec.describe "/news_messages", type: :request do
  let!(:news_messages) {
    create(:news_message)
  }
  let(:valid_attributes) {
    "What's the latest climate news for August 03, 2024"
  }
  let(:duplicate_attributes) {
    "What's the latest climate news for August 02, 2024"
  }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_news_messages_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get api_v1_news_message_url(news_messages.id), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new NewsMessage" do
        expect {
          post api_v1_news_messages_url, params: { news_message: { message_body: valid_attributes } }, as: :json
        }.to change(NewsMessage, :count).by(1)
      end

      it "renders a JSON response with the new news_message" do
        post api_v1_news_messages_url, params: { news_message: { message_body: valid_attributes } }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with duplicate parameters" do
      it "doesn't create a new NewsMessage" do
        expect {
          post api_v1_news_messages_url, params: { news_message: { message_body: duplicate_attributes } }, as: :json
        }.to change(NewsMessage, :count).by(0)
      end

      it "renders a JSON response with the existing news_message" do
        post api_v1_news_messages_url, params: { news_message: { message_body: duplicate_attributes } }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested news_message" do
      expect {
        delete api_v1_news_message_url(news_messages.id), as: :json
      }.to change(NewsMessage, :count).by(-1)
    end
  end
end
