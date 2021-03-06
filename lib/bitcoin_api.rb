require 'net/http'
require 'openssl'
require 'json'

class BitcoinAPI
  
  def initialize(api_key)
    @API_KEY = api_key
    @URLS = {
      rate: URI('https://bitcoinapi.de/v1/' + @API_KEY + '/rate.json'),
      orderbook: URI('https://bitcoinapi.de/v1/' + @API_KEY + '/orderbook.json'),
      history: URI('https://bitcoinapi.de/v1/' + @API_KEY + '/trades.json')
    }
  end

  def pull_data(type = :rate)
    url = @URLS[type]
    response = Net::HTTP.start(url.host,url.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      request = Net::HTTP::Get.new url
      http.request(request) 
    end
    JSON.load(response.body)    
  end

  def pull_orderbook
    pull_data(:orderbook)
  end

  def pull_rate
    pull_data(:rate)
  end

  def pull_history
    pull_data(:history)
  end
end