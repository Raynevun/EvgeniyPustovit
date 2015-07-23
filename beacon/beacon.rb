class BeaconAPI

  require 'net/http'
  require 'json'
  require 'nori'

  attr_accessor :func, :param
  attr_reader :response, :value

  BASE_URL = 'https://beacon.nist.gov/rest/record'

  def initialize( default_function = '/last', default_param = 'outputValue' )
    @url = BASE_URL
    @func = default_function
    @param = default_param
  end

  def get_response( func = @func )
    @response_raw = request( func )
    @response = parse_response[ 'record' ]
  end

  def get_param( param = @param )
    @value = @response[ param ] if @response
  end

  private

  def request( func = @func )
    Net::HTTP.get_response( URI(@url + func) )
  end

  def parse_response
    Nori.new.parse( @response_raw.body )
  end

end