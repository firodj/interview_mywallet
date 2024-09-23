require 'net/http'
require 'json'
require 'uri'

module LatestStockPrice
  class Fetcher
    def initialize(identifier)
      @identifier = identifier
    end

    def fetch
      url = URI("https://latest-stock-price.p.rapidapi.com/any")
      url.query = URI.encode_www_form([["Identifier", @identifier]]) #unless @identifier.blank?

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = ''
      request["x-rapidapi-host"] = 'latest-stock-price.p.rapidapi.com'

      response = http.request(request)
      JSON.parse(response.read_body)
    rescue StandardError => e
      raise LatestStockPrice::Error, "Error fetching stock price: #{e.message}"
    end
  end
end
