require 'tdameritrade/operations/base_operation'

module TDAmeritrade; module Operations
  class GetTransactions < BaseOperation

    def call(account_id)
      ['https://api.tdameritrade.com/v1/accounts',
        account_id,
        'transactions'
      ].join('/').tap do |url|
        return parse_api_response(perform_api_get_request(url: url))
      end
    end

  end
end; end
