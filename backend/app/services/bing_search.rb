class BingSearch < ApplicationService
  require 'net/https'
  require 'uri'
  require 'erb'
  require 'json'
  require 'nokogiri'

  include SearchHelper
  include ERB::Util

  attr_accessor :search_term

  def initialize(search_term)
    super
    @access_key = search_api_key
    @origin_uri = 'https://api.bing.microsoft.com'
    @path = '/v7.0/search'
    @term = search_term
  end

  def call
    return { "error": 'Invalid Bing Search API subscription key!' } unless valid_key?(@access_key)

    uri = URI("#{@origin_uri}#{@path}?q=#{url_encode(@term)}&count=5&responseFilter=webpages,news")
    response = create_request(uri)
    return { "error": 'no results found' } if response.is_a?(Net::HTTPNotFound)

    parsed_response = JSON.parse(response.body)
    results = parsed_response.dig('webPages', 'value')
    NewsMessage.create(message_body: results, is_bot: true)
    JSON.pretty_generate(JSON({ "error": 'no results found' })) if results.empty?
    create_news_records(results[0..4])
  end

  private

  def valid_key?(key)
    key.length == 32
  end

  def create_request(uri)
    request = build_request(uri)
    execute_request(request, uri)
  end

  def build_request(uri)
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = @access_key
    request
  end

  def execute_request(request, uri)
    call_attempt = 0
    begin
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        call_attempt += 1
        http.request(request) if call_attempt < 3
      end
    rescue StandardError => e
      Rails.logger.error "Failed to call #{uri}: #{e.message}"
    end
  end

  def summary(url)
    response = create_request(url)
    return unless response.is_a?(Net::HTTPSuccess) && response.body

    Nokogiri::HTML(response.body).css('body').css('p').first(5).map(&:text).join(' ')
  end

  def images(uri)
    response = Net::HTTP.get_response(uri)
    return [] unless response.is_a?(Net::HTTPSuccess) && response.body

    html = Nokogiri::HTML(response.body)
    img_elements = html.css('body').css('img')

    img_elements.select { |img| valid_src?(img['src']) }.map { |img| img['src'] }
  end

  def valid_src?(src)
    return false unless src&.match?(%r{^https?:/})
    return false unless src&.match?(/(jpg|jpeg|png|gif)/i)

    true
  end

  def create_news_records(results)
    results.map do |result|
      create_news_record(result)
    end
  end

  def create_news_record(result)
    uri = URI(result['url'])
    News.create(
      title: result['name'],
      url: result['url'],
      summary: summary(uri) || result['snippet'],
      published_at: parse_published_at(result),
      site_name: result['siteName'],
      images: images(uri)
    )
  end

  def parse_published_at(result)
    return unless result['datePublished']

    DateTime.iso8601(result['datePublished'])
  end
end
