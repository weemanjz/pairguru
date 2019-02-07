class MovieDataPuller
  BASE_URI = "https://pairguru-api.herokuapp.com/api/v1/movies".freeze

  def call(title)
    @title = title
    do_request
    parsed_response.dig("data", "attributes") || {}
  end

  private

  attr_reader :title, :response

  def do_request
    @response = Rails.cache.fetch("#{title} API data", expires_in: 24.hours) do
      uri = URI.encode("#{BASE_URI}/#{title}")
      Net::HTTP.get(URI(uri))
    end
  end

  def parsed_response
    JSON.parse(response)
  rescue JSON::ParserError
    {}
  end
end
