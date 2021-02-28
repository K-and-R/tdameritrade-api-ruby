require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetAccounts < BaseOperation

    def call
      response = perform_api_get_request(url: "https://api.tdameritrade.com/v1/accounts")
      parse_api_response(response)
    end

  end
end; end
