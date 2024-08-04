module NewsHelpers
  def summary(uri)
    response = Net::HTTP.get_response(uri)
    return unless response.is_a?(Net::HTTPSuccess) && response.body

    Nokogiri::HTML(response.body, nil, Encoding::UTF_8.to_s).css('body').css('p').first(5).map(&:text).join(' ')&.strip
  end

  def images(uri)
    response = Net::HTTP.get_response(uri)
    return [] unless response.is_a?(Net::HTTPSuccess) && response.body

    html = Nokogiri::HTML(response.body)
    img_elements = html.css('body').css('img')

    img_elements.select { |img| valid_src?(img['src']) }.pluck('src')[0..2]
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
    return if News.exists?(url: result['url'])

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
