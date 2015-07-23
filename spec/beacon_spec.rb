require 'spec_helper'

describe 'BeaconAPI' do

  describe '.new' do
    context 'when created' do
      context 'with default params' do
        before :all do
          @beacon = BeaconAPI.new
        end
        it 'has instance variables with appropriate values' do
          expect( @beacon.instance_variable_get( :@url ) ).to eq( 'https://beacon.nist.gov/rest/record' )
          expect( @beacon.func ).to eq( '/last' )
          expect( @beacon.param ).to eq( 'outputValue' )
        end
      end
      context 'with custom params' do
        before :all do
          @beacon = BeaconAPI.new( '/next', 'signature' )
        end
        it 'has instance variables with appropriate values' do
          expect( @beacon.instance_variable_get( :@url ) ).to eq( 'https://beacon.nist.gov/rest/record' )
          expect( @beacon.func ).to eq( '/next' )
          expect( @beacon.param ).to eq( 'signature' )
        end
      end
    end
  end

  describe '.get_response' do
    context 'with any @function' do
      before :all do
        @beacon = BeaconAPI.new
        @beacon.get_response
      end
      it 'appropriate instance variables contain data' do
        expect( @beacon.response ).to_not be_nil
        expect( @beacon.instance_variable_get( :@response_raw ) ).to_not be_nil
      end
    end
    context 'with @function by default' do
      context 'defined by constructor' do
        before :all do
          @beacon = BeaconAPI.new
          @beacon.get_response
        end
        it 'get raw response' do
          expect( @beacon.instance_variable_get(:@response_raw).uri.to_s ).to match( /last$/ )
          expect( @beacon.instance_variable_get(:@response_raw).code ).to match( '200' )
          expect( @beacon.instance_variable_get(:@response_raw).message ).to match( 'OK' )
          expect( @beacon.instance_variable_get(:@response_raw).body ).to_not be_nil
        end
        it 'get parsed response' do
          expect( @beacon.response[ 'statusCode' ] ).to eq( '0' )
        end
        it 'have @outputValue in response' do
          expect( @beacon.response[ 'outputValue' ] ).to_not be_nil
        end
      end
      context 'changed manually after initialization' do
        before :all do
          @beacon = BeaconAPI.new
          @beacon.func = '/next/1437662820'
          @beacon.get_response
        end
        it 'get raw response' do
          expect( @beacon.instance_variable_get(:@response_raw).uri.to_s ).to match( /next\/1437662820$/ )
          expect( @beacon.instance_variable_get(:@response_raw).code ).to eq( '200' )
          expect( @beacon.instance_variable_get(:@response_raw).message ).to eq( 'OK' )
          expect( @beacon.instance_variable_get(:@response_raw).body ).to_not be_nil
        end
        it 'get parsed response' do
          expect( @beacon.response[ 'statusCode' ] ).to eq( '0' )
        end
        it 'have @outputValue in response' do
          expect( @beacon.response[ 'outputValue' ] ).to_not be_nil
        end
      end
    end
    context 'with custom @function' do
      before :all do
        @beacon = BeaconAPI.new
        @beacon.get_response( '/next/1437662820' )
      end
      it 'get raw response' do
        expect( @beacon.instance_variable_get(:@response_raw).uri.to_s ).to match( /next\/1437662820$/ )
        expect( @beacon.instance_variable_get(:@response_raw).code ).to eq( '200' )
        expect( @beacon.instance_variable_get(:@response_raw).message ).to eq( 'OK' )
        expect( @beacon.instance_variable_get(:@response_raw).body ).to_not be_nil
      end
      it 'get parsed response' do
        expect( @beacon.response[ 'statusCode' ] ).to eq( '0' )
      end
      it 'have @outputValue in response' do
        expect( @beacon.response[ 'outputValue' ] ).to_not be_nil
      end
    end
    context 'with empty @function' do
      before :all do
        @beacon = BeaconAPI.new
        @beacon.get_response( '' )
      end
      it 'get raw response' do
        expect( @beacon.instance_variable_get(:@response_raw).uri.to_s ).to eq( 'https://beacon.nist.gov/rest/record' )
        expect( @beacon.instance_variable_get(:@response_raw).code ).to eq( '404' )
        expect( @beacon.instance_variable_get(:@response_raw).message ).to eq( 'Not Found' )
      end
      it 'parsed response should be nil' do
        expect( @beacon.response ).to be_nil
      end
    end
  end

  context '.get_param' do
    context 'with valid response' do
      context 'get default param' do
        before :all do
          @beacon = BeaconAPI.new
          @beacon.get_response
        end
        it 'return @outputValue' do
          expect( @beacon.get_param ).to eq( @beacon.response[ 'outputValue' ] )
        end
      end
      context 'get each param' do
        before :all do
          @beacon = BeaconAPI.new
          @beacon.get_response
        end
        it 'return each param' do
          @beacon.response.each_key do | key |
            expect( @beacon.get_param( key ) ).to eq( @beacon.response[ key ] )
          end
        end
      end
    end
    context 'with invalid response - nil' do
      before :all do
        @beacon = BeaconAPI.new
      end
      it 'return nil' do
        expect( @beacon.get_param ).to be_nil
      end
    end
  end

end

# describe ".request" do
#   it 'has valid output' do
#     expect(object.send(:request)).to
#   end
# end


