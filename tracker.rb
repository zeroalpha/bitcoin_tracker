require 'pry'

require File.dirname(__FILE__) + '/lib/bitcoin_api.rb'

api = BitcoinAPI.new File.read('api_key.sec').chomp
binding.pry
puts ""