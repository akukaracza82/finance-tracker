class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(publishable_token: ENV['iex_api'],
                                  endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
      where(ticker: ticker_symbol).first
  end
end

#  client is defined to get info from IEX based on an API key kept in .env file
# it works on sandbox enpoint. Sandbox mode available on their website
#  begin - rescue - end #=> designed to rescue an app from an error that comes up.
#  it is here to make sure, that it returns nil when client doesnt return any result
#  and therefore gives alert, that invalid symbol has been entered in stocks_controller
