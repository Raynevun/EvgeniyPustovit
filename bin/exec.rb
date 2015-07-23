require_relative '../beacon/beacon'
require_relative '../beacon/chaos'

include Chaos

api = BeaconAPI.new
api.get_response
api.get_param

order_and_print( api.value )
