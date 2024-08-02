module SearchHelper
  def search_api_key
    ENV['BING_SEARCH_API_KEY'] || Rails.application.credentials.dig(:search_api_key)
  end
end