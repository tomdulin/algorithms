
require 'test_helper'
# Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
# The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
class valid_parentheses
  KEY_IN  = "({["    # these values trigger push stack
  KEY_OUT = ")}]"    # these values trigger validation of paired item
  PAIR = {")" => "(", "}" => "{", "]" => "["} # hash close tag to open tag

  # @param {String} s
  # @return {Boolean}
  def is_valid(s)
    return true if s.nil?
    stack = []
    s.scan(/[({\[)}\]]/).each do |paren|
      if KEY_IN.include?(paren)
        stack << paren
      elsif KEY_OUT.include?(paren)
        return false unless stack.pop == PAIR[paren]
      else
        return false
      end
    end
    return stack.empty?
  end
end

class ValidParenthesesTest < ActiveSupport::TestCase
  test "should_work" do
    test_data.each do |l1, l2|
      puts "#{l1} -- #{l2}"
      assert_equal is_valid(l1), l2
    end
  end

  def test_data
    [
        ["[", false],
        ["()", true],
        ["()[]{}", true],
        ["((((([]{})))))", true],
        ["(1)[1]{232323}", true],
        ["(]",false],
        ["([)]",false],
        ["()[]{}}",false]
    ]
  end
end

