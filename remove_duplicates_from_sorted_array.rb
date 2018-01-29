require 'test_helper'

# Given a sorted array, remove the duplicates in-place such that each element appear only once and return the new length.

# Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

# Example:

# Given nums = [1,1,2],

# Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.
# It doesn't matter what you leave beyond the new length.


class remove_duplicates_from_sorted_array
  # @param {Integer[]} nums
  # @return {Integer}
  def remove_duplicates(nums)
    nums.uniq!
    nums.length
    idx = 0
    while idx < nums.length - 1
      if nums[idx] == nums[idx + 1]
        nums.delete_at(idx)
      else
        idx += 1
      end
    end
    return nums.length
  end
end

class RemoveDuplicatesFromSortedArrayTest < ActiveSupport::TestCase
  test "should_work" do
    test_data.each do |l1, l2|
      result = remove_duplicates(l1)
      puts "#{l1} -- #{result}"
      assert_equal result, l2
    end
  end

  def test_data
    [
        [[1,1,1],1],
        [[1,1],1],
        [[1,1,2],2],
        [[],0] ,
        [[1],1]
    ]
  end
end


