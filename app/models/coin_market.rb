# frozen_string_literal: true

require 'faraday'

# Plain Old Ruby Object as model.
# It is used for accessing CoinMarketCap APIs.
class CoinMarket
  # Antipattern. For convinience.
  def initialize
    @base_url = 'https://sandbox-api.coinmarketcap.com'
    @api_key = ENV['COIN_MARKET_CAP_API_KEY']
  end

  # Connects to CoinMarketCap API,
  # gets top 10 currencies sorted by market cap.
  # Caching response for 1 minute.
  # Alternatively we could cache this as rendered HTML in view.
  #
  # @return [String] response body JSON
  def top_ten
    Rails.cache.fetch('top_ten_resp', expires_in: 1.minutes) do
      conn = Faraday.new(url: @base_url) do |faraday|
        faraday.adapter(Faraday.default_adapter)
      end

      resp = conn.get do |req|
        req.url '/v1/cryptocurrency/listings/latest'
        req.headers['X-CMC_PRO_API_KEY'] = @api_key
        req.params['start'] = 1
        req.params['limit'] = 10
        req.params['convert'] = 'USD'
        req.params['sort'] = 'market_cap'
        req.params['sort_dir'] = 'desc'
      end

      raise 'Cannot parse response body' unless resp.body

      resp.body
    end
  end
end
