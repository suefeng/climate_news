require "rails_helper"

RSpec.describe NewsThreadsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/news_threads").to route_to("news_threads#index")
    end

    it "routes to #show" do
      expect(get: "/news_threads/1").to route_to("news_threads#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/news_threads").to route_to("news_threads#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/news_threads/1").to route_to("news_threads#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/news_threads/1").to route_to("news_threads#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/news_threads/1").to route_to("news_threads#destroy", id: "1")
    end
  end
end
