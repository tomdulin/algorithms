
require 'test_helper'

# Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

# For example, given n = 3, a solution set is:

# [
#   "((()))",
#   "(()())",
#   "(())()",
#   "()(())",
#   "()()()"
# ]

class generate_parentheses
  # @param {Integer} n
  # @return {String[]}
  def generate_parenthesis(n)
    buffer = []
    return buffer unless n >= 1
    recurse(buffer, "", n, n)
    buffer
  end

  def recurse(buffer, paren, left, right)
    # our result happens when there are no more parens to add
    if right == 0 && left == 0
      buffer << paren
    else
      # always recurse on left parens, but we cant recurse on right parens unless
      # the associated left paren has been already added
      recurse(buffer, paren + "(", left - 1, right) unless left == 0
      recurse(buffer, paren + ")", left, right - 1) if right > 0 && right > left
    end
  end
end

class GenerateParenthesesTest < ActiveSupport::TestCase
  test "should_work" do
    test_data.each do |l1, l2|
      result = generate_parenthesis(l1)
      puts "#{l1} -- #{result}"
      assert_equal result, l2
    end
  end


  def test_data
    [
        [0,[]],
        [1,["()"]],
        [2,["(())", "()()"]],
        [3,[
            "((()))",
            "(()())",
            "(())()",
            "()(())",
            "()()()"
          ]]
    ]
  end
end

