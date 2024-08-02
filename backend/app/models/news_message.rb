class NewsMessage < ApplicationRecord
  after_create :bing_search_call

  def bing_search_call
    BingSearch.call(self.message_body)
  end
end
