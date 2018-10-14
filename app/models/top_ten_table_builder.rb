# frozen_string_literal: true

require 'json'

# Creates table structure from CoinMarketCap API response.
# Table is represented as array of arrays.
# It has 10 rows and 4 Columns:
# Currency Code, Currency Name, Market Cap, Value in USD.
#
# Items in CoinMarket response JSON
# should be already ordered by Market Cap (descending).
class TopTenTableBuilder
  # Raise it when parser cannot normally parse response JSON from CoinMarket
  class ParserError < RuntimeError
    def message
      'cannot parse top ten json string'
    end
  end

  # Raise it when response JSON from CoinMarket has error_code != 0 in body
  class ResponseError < RuntimeError
    def message
      'response with non-zero error_code'
    end
  end

  # @param top_ten_resp [String] CoinMarket response body JSON
  #
  # @return [Array<Array>]
  def create_from_top_ten_resp!(top_ten_resp)
    table = []

    parsed_data = _parse_data_from_resp(top_ten_resp)

    parsed_data.each do |pd|
      code = pd.fetch('symbol')
      name = pd.fetch('name')
      cap = pd['quote']['USD'].fetch('market_cap')
      price = pd['quote']['USD'].fetch('price')

      table << [code, name, cap, price]
    end

    table
  end

  private

    # @param top_ten_resp [String] CoinMarket response body JSON
    #
    # @return [Hash]
    def _parse_data_from_resp(top_ten_resp)
      parsed_hash = JSON.parse(top_ten_resp)

      # sometimes #parse returns String instead of Hash
      raise TopTenTableBuilder::ParserError unless parsed_hash.is_a? Hash
      raise TopTenTableBuilder::ResponseError unless _is_status_error(parsed_hash)

      parsed_hash.fetch('data')
    end

    # @param parsed_hash [Hash]
    #
    # @return [true, false]
    def _is_status_error(parsed_hash)
      parsed_hash.dig('status', 'error_code') == 0
    end
end
