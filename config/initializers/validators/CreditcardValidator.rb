# CreditcardValidator.rb
# Holograms, Inc.
# Author: Anna Clayton
# Date created: Oct 14 2012
#
# This validator is used to validate that an input credit card number is valid.
# 
# Credit card numbers can be validated by the Luhn Algorithm
# (http://en.wikipedia.org/wiki/Luhn_algorithm) which is a simple checksum
#
# The formula verifies a number against its included check digit, which is usually
# appended to a partial account number to generate the full account number.
# This account number must pass the following test:
# - Counting from the check digit, which is the rightmost, and moving left, double the value of every second digit.
# - Sum the digits of the products (e.g., 10: 1 + 0 = 1, 14: 1 + 4 = 5) together with the undoubled digits from the
#   original number.
# If the total modulo 10 is equal to 0 (if the total ends in zero) then the number is valid according to the Luhn
# formula; else it is not valid.
class CreditcardValidator < ActiveModel::EachValidator
  
  #validate credit card number
  def validate_each(record,attribute,value)
    unless Luhn::check_luhn(value)
      record.errors[attribute] << 'is not a valid credit card number'
    end
    unless Luhn::isValidType(value)
      record.errors[attribute] << 'is not a valid credit card type. We currently accept MC, Visa, Discover, and AmEx'
    end
  end
end

class Luhn
  def self.check_luhn(s)
    s.gsub!(/[^0-9]/, "")  # Remove any character that's not a digit
    ss = s.reverse.split(//) # Split the input to an array each containing one character
 
    alternate = false
    total = 0
    # For each character,
    # if it's an even numbered character, double it, reduce to one digit, and add to sum
    # if it's an odd numbered character, just add to sum
    ss.each do |c| 
      if alternate
         total += double_it(c.to_i)
      else
         total += c.to_i
      end
      alternate = !alternate
    end
    # return the result of total mod 10
    total % 10 == 0
  end
 
  def self.double_it(i)
    i = i * 2
    if i > 9
      i = i % 10 + 1
    end
    i
  end
  
  def self.isValidType(s)
    # http://money.howstuffworks.com/personal-finance/debt-management/credit-card1.htm
    s.gsub!(/[^0-9]/, "") # Remove any character that's not a digit
    result = false # Initialize
    if s.empty?
      result = true # Don't fail for empty string since credit card is not a required field
    end
    if s.start_with?("37")
      result = true # American Express
    end  
    if s.start_with?("4")
       result = true # Visa
    end   
    if s.start_with?("5")
        result = true # MasterCard
    end    
    if s.start_with?("6")
        result = true # Discover
    end    
    result
  end
end

  
  
 

