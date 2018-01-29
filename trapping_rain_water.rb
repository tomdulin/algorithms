require 'test_helper'


# Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

# For example, 
# Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.


# The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

class trapping_rain_water
  # @param {Integer[]} height
  # @return {Integer}
  def trap(height)
    return 0 if height.nil? || height.length < 3
    n = height.length
    left  = Array.new(n)
    right = Array.new(n)

    water = 0
    lp = 1
    rp = n-2

    right[n-1] = height[n-1]
    left[0]    = height[0]

    while rp >= 0
      left[lp]  = max(left[lp-1],  height[lp])
      right[rp] = max(right[rp+1], height[rp])
      rp -= 1
      lp += 1
    end

    (0..n-1).each do |pos|
      water += min(left[pos], right[pos]) - height[pos]
    end
    water
  end


  def min left, right
    left > right ? right : left
  end

  def max left, right
    left < right ? right : left
  end
end

class TrappingRainWaterTest < ActiveSupport::TestCase
  test "should_work" do
    test_data.each do |l1, l2|
      result = trap(l1)
      puts "#{l1} -- #{result}"
      assert_equal result, l2
    end
  end


  def test_data
    [
        [[0,1,0,2,1,0,1,3,2,1,2,1], 6]
    # [[],],
    ]
  end
end

