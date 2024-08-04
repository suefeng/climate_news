class BingSearch < ApplicationService
  include SearchHelpers
  include ERB::Util

  attr_accessor :search_term

  def initialize(search_term)
    @access_key = search_api_key
    @origin_uri = 'https://api.bing.microsoft.com'
    @path = '/v7.0/search'
    @term = search_term
  end

  def call
    return { error: 'Invalid Bing Search API subscription key!' } unless valid_key?(@access_key)

    uri = "#{@origin_uri}#{@path}?q=#{url_encode(@term)}&count=5&responseFilter=webpages,news&freshness=Day"
    Https.new(uri, 'Ocp-Apim-Subscription-Key', @access_key).call
  end

  private

  def valid_key?(key)
    key.length == 32
  end
end
