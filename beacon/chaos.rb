module Chaos

  def order( str = '' )
    res = {}
    str.each_char do | char |
      res[char] ? res[char] += 1 : res[char] = 1
    end
    res
  end

  def print_result( hash = {} )
    if hash && hash != {}
      puts 'ch:num'
      hash.each { | key, value | puts key + ' : ' + value.to_s }
    else
      puts 'nothing to print'
    end
  end

  def order_and_print( str = '' )
    print_result( order( str ) )
  end

end