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
    @accessKey = search_api_key
    @origin_uri  = "https://api.bing.microsoft.com"
    @path = "/v7.0/search"
    @term = search_term
  end

  def call
    if @accessKey.length != 32 then
      return JSON::pretty_generate(JSON({"error": "Invalid Bing Search API subscription key!"}))
    end

    uri = URI(@origin_uri + @path + "?q=" + url_encode(@term) + "&count=5&responseFilter=webpages,news")

    response = create_request(uri)

    return JSON::pretty_generate(JSON({"error": "no results found" })) if response.is_a?(Net::HTTPNotFound)

    parsed_response = JSON.parse(response.body)
    results = parsed_response.dig("webPages", "value")

    NewsMessage.create(message_body: results, is_bot: true)
    return JSON::pretty_generate(JSON({"error": "no results found" })) if results.length == 0 

    results[0..4].map do |result|
      news_article = News.new
      uri = URI(result["url"])
      article_summary = summary(uri)
      article_images = images(uri)
      news_article.title = result["name"]
      news_article.url = result["url"]
      news_article.summary = article_summary || result["snippet"]
      news_article.published_at = result["datePublished"] && DateTime.iso8601(result["datePublished"])
      news_article.site_name = result["siteName"]
      news_article.images = article_images
      news_article.save
    end
  end

  private

  def create_request(uri)
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = @accessKey

    call_attempt = 0
    begin
      response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        call_attempt += 1
        http.request(request) if call_attempt < 3
      end
    rescue StandardError => e
      Rails.logger.error "Failed to call #{uri}: #{e.message}"
    end
  end

  def summary(url)
    response = create_request(url)
    summary_text = ""
    if response.is_a?(Net::HTTPSuccess)
      if response.body
        html = Nokogiri::HTML(response.body)

        if html
          summary_text = html.css("body").css("p").first(5).map(&:text).join(" ")
        end
      end
    end
    return summary_text
  end

  def images(url)
    response = create_request(url)
    images = []
    if response.is_a?(Net::HTTPSuccess)
      if response.body
        html = Nokogiri::HTML(response.body)

        if html
          html.css("body").css("img").map do |img|
            if img["src"] != nil && 
              img["src"].match(/^https?:\//) && 
              img["src"].match(/(jpg|jpeg|png|gif)/i)

              images.push(img["src"])
            end
          end
        end
      end
    end
    return images
  end
end
