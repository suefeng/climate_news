class Https
  def initialize(uri, request_key, request_key_value)
    @uri = URI(uri)
    @request_key = request_key
    @request_key_value = request_key_value
  end

  def call
    request = build_request
    response = create_request(request)
    return { error: 'no results found' } if response.is_a?(Net::HTTPNotFound)

    parsed_response = JSON.parse(response.body)
    results = parsed_response.dig('webPages', 'value')
    return { error: 'no results found' } if results.blank?

    results
  end

  def build_request
    request = Net::HTTP::Get.new(@uri)
    request[@request_key] = @request_key_value
    request
  end

  def create_request(request)
    call_attempt = 0
    begin
      Net::HTTP.start(@uri.host, @uri.port, use_ssl: @uri.scheme == 'https') do |http|
        call_attempt += 1
        http.request(request) if call_attempt < 3
      end
    rescue StandardError => e
      Rails.logger.error "Failed to call #{@uri}: #{e.message}"
    end
  end
end
