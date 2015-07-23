require 'spec_helper'

describe '.order' do

  context 'string is provided' do
    it 'count each character' do
      expect( order( 'q11wwe55rrrtt3333yyyyy' ) ).to eq( {'q'=>1, '1'=>2, 'w'=>2, 'e'=>1, '5'=>2, 'r'=>3, 't'=>2, '3'=>4, 'y'=>5} )
      expect( order( 'yqw88yw5rety8ryr2t2yy' ) ).to eq( {'y'=>6, 'q'=>1, 'w'=>2, '8'=>3, '5'=>1, 'r'=>3, 'e'=>1, 't'=>2, '2'=>2} )
    end
  end

  context 'empty string is provided' do
    it 'return empty hash' do
      expect( order( '' ) ).to eq( {} )
    end
  end

  context 'parameter is absent' do
    it 'return empty hash' do
      expect( order() ).to eq( {} )
    end
  end

end

describe '.print_result' do

  context 'hash is provided' do
    it 'print result' do
      expect{ print_result( {'q'=>1, '1'=>2, 'w'=>2, 'e'=>1, '5'=>2, 'r'=>3, 't'=>2, '3'=>4, 'y'=>5} ) }.to output( "q , 1\n1 , 2\nw , 2\ne , 1\n5 , 2\nr , 3\nt , 2\n3 , 4\ny , 5\n" ).to_stdout
    end
  end

  context 'empty hash is provided' do
    it 'print message' do
      expect{ print_result( {} ) }.to output( "nothing to print\n" ).to_stdout
    end
  end

  context 'parameter is absent' do
    it 'print message' do
      expect{ print_result() }.to output( "nothing to print\n" ).to_stdout
    end
  end

  context 'parameter is nil' do
    it 'print message' do
      expect{ print_result( nil ) }.to output( "nothing to print\n" ).to_stdout
    end
  end

end

describe '.order_and_print' do

  context 'string is provided' do
    it 'count each character and print result' do
      expect{ order_and_print( 'q11wwe55rrrtt3333yyyyy' ) }.to output( "1 , 2\n3 , 4\n5 , 2\ne , 1\nq , 1\nr , 3\nt , 2\nw , 2\ny , 5\n" ).to_stdout
      expect{ order_and_print( 'yqw88yw5rety8ryr2t2yy' ) }.to output( "2 , 2\n5 , 1\n8 , 3\ne , 1\nq , 1\nr , 3\nt , 2\nw , 2\ny , 6\n" ).to_stdout
    end
  end

  context 'empty string is provided' do
    it 'print message' do
      expect{ order_and_print( '' ) }.to output( "nothing to print\n" ).to_stdout
    end
  end

  context 'parameter is absent' do
    it 'print message' do
      expect{ order_and_print( '' ) }.to output( "nothing to print\n" ).to_stdout
    end
  end

end