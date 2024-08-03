class NewsMessage < ApplicationRecord
  include NewsHelpers

  after_create :bing_search_call

  attr_accessor :skip_bing_search

  validates :message_body, presence: true

  def bing_search_call
    return if Rails.env.test? || skip_bing_search || is_bot == true

    parsed_message = message_body["query"]

    results = BingSearch.call(parsed_message) if parsed_message != ''
    NewsMessage.create(message_body: results, is_bot: true)
    create_news_records(results[0..4])
  end
end
