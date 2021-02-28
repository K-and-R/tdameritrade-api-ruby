require 'tdameritrade/operations/base_operation'

# https://developer.tdameritrade.com/option-chains/apis/get/marketdata/chains
module TDAmeritrade; module Operations
  class GetOptionChain < BaseOperation

    # Not used right now, but can be used later on for validation
    FREQUENCY_TYPE=[:minute, :daily, :weekly, :monthly]
    PERIOD_TYPE=[:day, :month, :year, :ytd]

    # symbolized versions of parameters from API call
    # https://developer.tdameritrade.com/option-chains/apis/get/marketdata/chains
    PARAMETERS = %i[
      contract_type strike_count include_quotes strategy interval
      strike range frequency from_date to_date volatility underlying_price
      interest_rate days_to_expiration exp_month option_type
    ].freeze

    def call(
      symbol,
      args = { include_quotes: true }
    )
      params = {
        symbol: symbol.upcase,
        apikey: client.client_id
      }

      PARAMETERS.each do |parameter|
        if args[parameter].present?
          params[camelize(parameter)] = args[parameter]
        end
      end

      response = perform_api_get_request(
        url: "https://api.tdameritrade.com/v1/marketdata/chains",
        query: params
      )

      parsed_response = parse_api_response(response)

      parsed_response
    end

    private

    def camelize(symbol)
      symbol.to_s.split('_').inject([]) do |buffer, e|
        buffer.push(buffer.empty? ? e : e.capitalize)
      end.join
    end
  end
end; end
