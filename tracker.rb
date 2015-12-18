require 'pry'
require 'net/http'

def pull_current_orderbook
  url = URI("https://bitcoinapi.de/v1/YOUR_API_KEY/orderbook.json")
  Net::HTTP.start()
end