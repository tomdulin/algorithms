
# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

#   Example
#   Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
#   Output: 7 -> 0 -> 8
#   Explanation: 342 + 465 = 807.
  

class addtwonumbers
  def solve l1, l2
    result = ListNode.new(0)         # pointer to result array
    c1 = l1; c2 = l2; curr = result;
    balance = 0                    # handle mod 10 overage

    # because we are working least significant digit
    # we are adding as we go
    while (!c1.nil? || !c2.nil?)
     # to make code easier to read, handle if l1, l2 pointer has a value
     # otherwise cancel out with 0
     x = c1.nil? || c1.val.nil? ? 0 : c1.val  # int value of current digit unless null
     y = c2.nil? || c2.val.nil? ? 0 : c2.val  # int value of current digit unless null

     sum = balance + x + y               # add l1 and l2 pointer values

     curr.next = ListNode.new(sum % 10)  # add to results pointer with value under 10

     curr = curr.next

     balance = sum / 10                     # anything over 9

     # move l1/l2 pointers
     c1 = c1.next unless c1.nil?
     c2 = c2.next unless c2.nil?
    end

    # if we have a balance after adding last items
    curr.next = ListNode.new(balance)  unless balance == 0

    # our first pointer is 0, if there are valid lists, the answer starts at next
    result.next.nil? ? result : result.next
  end
end

class ListNode
  attr_accessor :val, :next
  def initialize(val)
    @val = val
    @next = nil
  end
end


class AddTwoNumberTest  < ActiveSupport::TestCase
  test "add_two_numbers_should_work" do
     test_data_converted.each do |l1, l2, l3|
       puts as_i(l3)
       puts as_i(addtwonumbers(l1, l2))
       assert_equal as_i(addtwonumbers(l1, l2)), as_i(l3)
     end
   end

  def test_data_converted
    test_data.map do |l1, l2|
      [l1.nil? ? nil : convert(l1),
       l2.nil? ? nil : convert(l2),
       l1.nil? || l2.nil? ? ListNode.new(0) : convert((l1+l2).to_s)]
    end
  end

  def as_i list
    return nil if list.nil? || list.val.nil?
    i = 0
    p = list
    while p.present?
     i *= 10
     i += p.val
     p = p.next
    end
    i
  end

  def test_data
    [
        [243, 564],
        [243, 564],
        [0, rand(0..100)],
        [nil, rand(0..100)],
        [rand(0..100), nil],
        [nil, nil],
        [0, 0],
        [rand(0..1), rand(0..100)],
        [rand(0..1000), rand(0..10)],
        [rand(0..100), rand(0..10000000000000000)]
    ]
  end

  def convert value
    return  ListNode.new(nil) if value.nil?
    l1 = nil      # head pointer
    prev = nil    # previous pointer
    curr = nil    # current pointer
    (value.to_s.split(//).reverse.map{|i| i.to_i}).each do |i|
      # first call
      if prev.nil?
        l1 = prev = ListNode.new(i)
      else
        curr = ListNode.new(i)
        prev.next = curr
        prev = curr
      end
    end
    l1
  end
end


