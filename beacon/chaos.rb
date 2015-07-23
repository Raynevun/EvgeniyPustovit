module Chaos

  def order
    res = {}

    self.each_char do | char |
      if res[ char ]
        res[ char ] += 1
      else
        res[ char ] = 1
      end
    end

    res
  end

  def print_result
    puts 'ch:num'
    self.each { | key, value | puts key + ' : ' + value.to_s }
  end

  def order_and_print
    self.order.print_result
  end

end