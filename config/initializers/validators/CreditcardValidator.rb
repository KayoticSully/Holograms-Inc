class CreditcardValidator < ActiveModel::EachValidator
  
  #validate credit card number
  def validate_each(record,attribute,value)
    unless Luhn::check_luhn(value)
      record.errors[attribute] << 'is not a valid credit card number'
    end
  end
end

class Luhn
  def self.check_luhn(s)
    s.gsub!(/[^0-9]/, "")
    ss = s.reverse.split(//)
 
    alternate = false
    total = 0
    ss.each do |c|
      if alternate
         total += double_it(c.to_i)
      else
         total += c.to_i
      end
      alternate = !alternate
    end
    total % 10 == 0
  end
 
  def self.double_it(i)
    i = i * 2
    if i > 9
      i = i % 10 + 1
    end
    i
  end
end
 

