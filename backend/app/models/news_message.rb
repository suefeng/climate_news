class NewsMessage < ApplicationRecord
  after_create :bing_search_call

  attr_accessor :skip_bing_search

  validates :message_body, presence: true

  def bing_search_call
    return if Rails.env.test? || skip_bing_search || is_bot == true

    parsed_message = message_body["query"]
    BingSearch.call(parsed_message) if parsed_message != ''
  end
end
