require 'test_helper'

# There are two sorted arrays nums1 and nums2 of size m and n respectively.

# Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

# Example 1:
# nums1 = [1, 3]
# nums2 = [2]
# The median is 2.0

# Example 2:
# nums1 = [1, 2]
# nums2 = [3, 4]
# The median is (2 + 3)/2 = 2.5


class MedianOfTwoSortedArrays
  # @param {Integer[]} nums1
  # @param {Integer[]} nums2
  # @return {Float}
  def find_median_sorted_arrays(nums1, nums2)
    total = nums1.length + nums2.length

    # get median of both arrays
    left  = find_k(nums1, 0, nums1.length - 1, nums2, 0, nums2.length - 1, (total + 1) / 2)

    # only need to get right if length of both arrays is even
    if total & 1 == 1
      right = left      # our median is left
    else
      # our median is the half the sum of left and right values
      right = find_k(nums1, 0, nums1.length - 1, nums2, 0, nums2.length - 1, (total + 2) / 2)
    end

    (left.to_f + right.to_f) / 2
  end
  # left_start/right_start are pointers to start of scope of array
  # left_end/right_end are pointers to the end of the scope of array
  # k is the pointer to the median of the current focus
  # result of this function is to find the value to the left or right of the median
  def find_k(left_nums, left_start, left_end, right_nums, right_start, right_end, k)
    length_l = left_end - left_start + 1
    length_r = right_end - right_start + 1

    # force smaller array to be first
    return find_k(right_nums, right_start, right_end, left_nums, left_start, left_end, k)  unless length_l <= length_r

    # smaller array is empty, get mean of larger array
    return right_nums[right_start + k - 1]                            unless length_l > 0

    # median is the lessor of the two remaining values
    return [right_nums[right_start], left_nums[left_start]].min       unless k > 1


    # preview possible route for left and right median
    new_left_k  =  left_start  + [length_l, k/2].min - 1
    new_right_k =  right_start + [length_r, k/2].min - 1

    if left_nums[new_left_k] > right_nums[new_right_k]
      find_k(left_nums, left_start, left_end, right_nums, new_right_k + 1, right_end, k - (new_right_k - right_start + 1))
    else
      find_k(left_nums, new_left_k + 1, left_end, right_nums, right_start, right_end, k - (new_left_k - left_start + 1))
    end
  end
end


class MedianOfTwoSortedArraysTest < ActiveSupport::TestCase
  test "median of two sorted arrays should work_work" do
    (0..10000).each do |d|
      test_data.each do |l1, l2, l3|
        puts "#{l1.to_s} - #{l2.to_s}  = #{l3}"
        # puts "#{l1.to_s} - #{l2.to_s}  = #{l3} ||| #{(l1.length + l2.length + 1)/2}"
        assert_equal find_median_sorted_arrays(l1, l2), l3
      end
    end
  end


  def test_data
    [
     [[1,3],[2], 2],
     [[1,2],[3, 4], 2.5],
     [[0],[0], 0],
     [[1,4,5,6,8,9],[], 5.5],
     [[1,2,3,4],[5,6,7,8,9], 5],
     [[1,4,5,6,8,9],[2,3], 4.5],
     [[1,3,6,7,8,9],[3], 6] ,
     [[1, 3, 14], [2, 2, 2], 2],
     [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,3,4],[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2], 2]
    ]
  end

end

