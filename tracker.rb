require 'pry'

require 'net/http'
require 'openssl'
require 'json'

class BitcoinAPI
  
  def initialize(api_key)
    @API_KEY = api_key
    @URLS = {
      rate: URI('https://bitcoinapi.de/v1/' + @API_KEY + '/rate.json'),
      orderbook: URI('https://bitcoinapi.de/v1/' + @API_KEY + '/orderbook.json')
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

  def pull_current_orderbook
    pull_data(:orderbook)
  end

  def pull_current_rate
    pull_data(:rate)
  end
end

api = BitcoinAPI.new File.read('api_key.sec').chomp
binding.pry
puts ""