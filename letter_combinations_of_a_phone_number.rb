require 'test_helper'

# Given a digit string, return all possible letter combinations that the number could represent.

# A mapping of digit to letters (just like on the telephone buttons) is given below.

# Input:Digit string "23"
# Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
# Note:
# Although the above answer is in lexicographical order, your answer could be in any order you want.
class letter_combinations_of_a_phone_number

  KEY = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]


  # @param {String} digits
  # @return {String[]}
  def letter_combinations(digits)
    return [] if digits.empty?
    buffer = []
    recurse(digits, 0, "", buffer)
    buffer
  end

  # digits - raw string input
  # index  - current digit
  # curr_string  = recursed value
  # buffer - array of results
  def recurse(digits, index, curr_string, buffer)
    current_number = digits[index].to_i
     if index == digits.length
       buffer << curr_string
     elsif current_number.nil? || KEY[current_number].nil?
       recurse(digits, index + 1, curr_string, buffer)
     else
       (0..KEY[current_number].length - 1).each do |alpha|
        recurse(digits, index + 1, curr_string + KEY[current_number][alpha], buffer)
       end
     end
  end

end

class LetterCombinationsOfAPhoneNumberTest < ActiveSupport::TestCase
  test "should_work" do
    test_data.each do |l1, l2|
      puts "#{l1} -- #{l2} -- #{letter_combinations(l1)}"
      assert_equal letter_combinations(l1), l2
    end
  end



  def test_data
    [
        # [1,"I"],
        ["2-3",["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]],
        ["203",["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]],
        ["23",["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"]],
        ["234", %w"adg adh adi aeg aeh aei afg afh afi bdg bdh bdi
                   beg beh bei bfg bfh bfi cdg cdh cdi ceg ceh cei cfg cfh cfi"]
    ]
  end
end

