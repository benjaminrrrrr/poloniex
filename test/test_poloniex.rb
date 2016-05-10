require 'minitest/autorun'
require 'yaml'
require_relative '../lib/poloniex'

class TestPoloniex < Minitest::Test
  def setup
    c = YAML.load_file('test/config.yml')
    Poloniex.setup do | config |
      config.key = c['key']
      config.secret = c['secret']
    end
  end

  def test_ticker
    response = JSON.parse(Poloniex.ticker)
    assert_equal(response["BTC_ETH"]["isFrozen"], "0")
  end

  #
  # def test_volume
  # end
  #
  # def test_order_book
  # end
  #
  # def test_trade_history
  # end
  #
  # def test_chart_data
  # end
  #
  # def test_currencies
  # end
  #
  # def test_loan_orders
  # end
  #
  # def test_balances
  # end
  #
  # def test_complete_balances
  # end
  #
  # def test_deposit_addresses
  # end
  #
  # def test_generate_new_ddress
  # end
  #
  # def test_deposits_withdrawls
  # end
  #
  # def test_open_orders
  # end
  #
  # def test_order_trades
  # end
  #
  # def test_buy
  # end
  #
  # def test_sell
  # end
  #
  # def test_cancel_order
  # end
  #
  # def test_move_order
  # end
  #
  # def test_withdraw
  # end
  #
  # def test_fee_info
  # end
  #
  # def test_available_account_balances
  # end
  #
  # def test_tradable_balances
  # end
  #
  # def test_transfer_balance
  # end
  #
  # def test_margin_account_summary
  # end
  #
  # def test_margin_buy
  # end
  #
  # def test_margin_sell
  # end
  #
  # def test_get_margin_position
  # end
  #
  # def test_close_margin_position
  # end
  #
  # def test_create_loan_offer
  # end
  #
  # def test_cancel_loan_offer
  # end
  #
  # def test_return_open_loan_offers
  # end
  #
  # def test_return_active_loans
  # end
  #
  # def test_toggle_auto_renew
  # end

end
