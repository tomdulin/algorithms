require 'test_helper'

# Given a 32-bit signed integer, reverse digits of an integer.

class ReverseInteger
  def reverse(x)
    # for support of typed languages that have int overflow.
    max_int = 2147483647
    min_int = -2147483648
    is_neg = x < 0

    x *= -1 if is_neg

    n_val = 0

    while(x != 0)
      n_val = n_val * 10 + x%10
      x = x/10
    end

    if n_val > max_int  || n_val < min_int
      return 0
    else
      return is_neg ? n_val * -1 : n_val
    end
  end
end

class ReverseIntegerTest < ActiveSupport::TestCase
  test "should_work" do
    test_data.each do |l1, l2|
      puts "#{l1} -- #{l2}"
      assert_equal reverse(l1), l2
    end
  end


  def test_data
    [
        [123,321],
        [-123, -321],
        [1000000003, 0],
        [100, 1]
    ]
  end
end

