require "poloniex/version"

require 'rest-client'
require 'openssl'
require 'addressable/uri'

module Poloniex

  class << self
    attr_accessor :configuration
  end

  def self.setup
    @configuration ||= Configuration.new
    yield( configuration )
  end

  class Configuration
    attr_accessor :key, :secret

    def intialize
      @key    = ''
      @secret = ''
    end
  end

  def self.ticker
    get 'returnTicker'
  end

  def self.volume
    get 'return24hVolume'
  end

  def self.order_book( currency_pair )
    get 'returnOrderBook', currencyPair: currency_pair
  end

  def self.trade_history(currency_pair, start_time, end_time)
    get 'returnTradeHistory', currencyPair: currency_pair, start: start_time, end: end_time
  end

  def self.chart_data(currency_pair, period, start_time, end_time)
    get 'returnChartData', currencyPair: currency_pair, period: period, start: start_time, end: end_time
  end

  def self.currencies
    get 'returnCurrencies'
  end

  def self.loan_orders(currency)
    get 'returnLoanOrders', currency: currency
  end

  def self.balances
    post 'returnBalances'
  end

  def self.complete_balances(account)
    post 'returnCompleteBalances', account: account
  end

  def self.deposit_addresses
    post 'returnDepositAddresses'
  end

  def self.generate_new_address
    post 'generateNewAddress'
  end

  def self.deposits_withdrawls(start_time, end_time)
    post 'returnDepositsWithdrawls', start: start_time, end: end_time
  end

  def self.open_orders( currency_pair )
    post 'returnOpenOrders', currencyPair: currency_pair
  end

  def self.order_trades(order_number)
    post 'returnOrderTrades', orderNumber: order_number
  end

  def self.buy(currency_pair, rate, amount)
    post 'buy', currencyPair: currency_pair, rate: rate, amount: amount
  end

  def self.sell(currency_pair, rate, amount)
    post 'sell', currencyPair: currency_pair, rate: rate, amount: amount
  end

  def self.cancel_order(order_number)
    post 'cancelOrder', orderNumber: order_number
  end

  def self.move_order(order_number, rate, amount)
    post 'moveOrder', orderNumber: order_number, rate: rate, amount: amount
  end

  def self.withdraw( curreny, amount, address )
    post 'widthdraw', currency: currency, amount: amount, address: address
  end

  def self.fee_info
    post 'returnFeeInfo'
  end

  def self.available_account_balances(account)
    post 'returnAvailableAccountBalances', account: account
  end

  def self.tradable_balances
    post 'returnTradableBalances'
  end

  def self.transfer_balance(currency, amount, from_account, to_account)
    post 'transferBalance', currency: currency, amount: amount, fromAccount: from_account, toAccount: to_account
  end

  def self.margin_account_summary
    post 'returnMarginAccountSummary'
  end

  def self.margin_buy(currency_pair, rate, amount)
    post 'marginBuy', currencyPair: currency_pair, rate: rate, amount: amount
  end

  def self.margin_sell(currency_pair, rate, amount)
    post 'marginSell', currencyPair: currency_pair, rate: rate, amount: amount
  end

  def self.get_margin_position(currency_pair)
    post 'getMarginPosition', currencyPair: currency_pair
  end

  def self.close_margin_position(currency_pair)
    post 'closeMarginPosition', currencyPair: currency_pair
  end

  def self.create_loan_offer(currency, amount, duration, auto_renew, lending_rate)
    post 'createLoanOffer', currency: currency, amount: amount, duration: duration, autoRenew: auto_renew, lendingRate: lending_rate
  end

  def self.cancel_loan_offer(order_number)
    post 'cancelLoanOffer'
  end

  def self.return_open_loan_offers
    post 'returnOpenLoanOffers'
  end

  def self.return_active_loans
    post 'returnActiveLoans'
  end

  def self.lending_history( currency_pair, start_date, end_date )
    post 'returnLendingHistory', currencyPair: currency_pair, start: start_date, end: end_date
  end

  def self.toggle_auto_renew
    post 'toggleAutoRenew'
  end

  protected

  def self.resource
    @@resouce ||= RestClient::Resource.new( 'https://www.poloniex.com' )
  end

  def self.get( command, params = {} )
    params[:command] = command
    resource[ 'public' ].get params: params
  end

  def self.post( command, params = {} )
    params[:command] = command
    params[:nonce]   = Time.now.to_i * 1000
    resource[ 'tradingApi' ].post params, { Key: configuration.key , Sign: create_sign( params ) }
  end

  def self.create_sign( data )
    encoded_data = Addressable::URI.form_encode( data )
    OpenSSL::HMAC.hexdigest( 'sha512', configuration.secret , encoded_data )
  end

end
