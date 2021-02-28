require 'tdameritrade/authentication'
require 'tdameritrade/client'
require 'tdameritrade/error'
require 'tdameritrade/version'
require 'tdameritrade/operations/create_watchlist'
require 'tdameritrade/operations/get_account'
require 'tdameritrade/operations/get_accounts'
require 'tdameritrade/operations/get_instrument_fundamentals'
require 'tdameritrade/operations/get_option_chain'
require 'tdameritrade/operations/get_price_history'
require 'tdameritrade/operations/get_quotes'
require 'tdameritrade/operations/get_transactions'
require 'tdameritrade/operations/get_watchlists'
require 'tdameritrade/operations/replace_watchlist'
require 'tdameritrade/operations/update_watchlist'
require 'tdameritrade/operations/get_orders'

module TDAmeritrade
  class Client
    include TDAmeritrade::Authentication
    include TDAmeritrade::Error

    def initialize(**args)
      @access_token = args[:access_token]
      @refresh_token = args[:refresh_token]
      @access_token_expires_at = args[:access_token_expires_at]
      @refresh_token_expires_at = args[:refresh_token_expires_at]
      @client_id = args[:client_id] || Error.gem_error('client_id is required!')
      @redirect_uri = args[:redirect_uri] || Error.gem_error('redirect_uri is required!')
    end

    def get_accounts
      Operations::GetAccounts.new(self).call
    end

    def get_account(account_id)
      Operations::GetAccount.new(self).call(account_id)
    end

    def get_orders(account_id = nil)
      Operations::GetOrders.new(self).call(account_id)
    end

    def get_transactions(account_id)
      Operations::GetTransactions.new(self).call(account_id)
    end

    def get_instrument_fundamentals(symbol)
      Operations::GetInstrumentFundamentals.new(self).call(symbol)
    end

    def get_option_chain(symbol, **options)
      Operations::GetOptionChain.new(self).call(symbol, options)
    end

    def get_price_history(symbol, **options)
      Operations::GetPriceHistory.new(self).call(symbol, options)
    end

    def get_quotes(symbols)
      Operations::GetQuotes.new(self).call(symbols: symbols)
    end

    def create_watchlist(account_id, watchlist_name, symbols)
      Operations::CreateWatchlist.new(self).call(account_id, watchlist_name, symbols)
    end

    def get_watchlists(account_id)
      Operations::GetWatchlists.new(self).call(account_id: account_id)
    end

    def replace_watchlist(account_id, watchlist_id, watchlist_name, symbols_to_add=[])
      Operations::ReplaceWatchlist.new(self).call(account_id, watchlist_id, watchlist_name, symbols_to_add)
    end

    def update_watchlist(account_id, watchlist_id, watchlist_name, symbols_to_add=[])
      Operations::UpdateWatchlist.new(self).call(account_id, watchlist_id, watchlist_name, symbols_to_add)
    end

  end
end
