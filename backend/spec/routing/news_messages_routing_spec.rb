require "rails_helper"

RSpec.describe NewsMessagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/news_messages").to route_to("news_messages#index")
    end

    it "routes to #show" do
      expect(get: "/news_messages/1").to route_to("news_messages#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/news_messages").to route_to("news_messages#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/news_messages/1").to route_to("news_messages#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/news_messages/1").to route_to("news_messages#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/news_messages/1").to route_to("news_messages#destroy", id: "1")
    end
  end
end
