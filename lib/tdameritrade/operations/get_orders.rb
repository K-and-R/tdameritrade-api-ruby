require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetOrders < BaseOperation

    def call(account_id = nil)
      "https://api.tdameritrade.com/v1/orders".tap do |url|
        url += ["?accountId=", account_id].join if account_id.present?
        return parse_api_response(perform_api_get_request(url: url))
      end
    end

  end
end; end
