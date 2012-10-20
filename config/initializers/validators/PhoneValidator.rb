# PhoneNumberValidator.rb
# Holograms, Inc.
# Author: Shane Steinert
# Date created: Oct 14 2012
#
# This validator is used to validate that an input phone number is valid.
#
# This validator checks that a phone number is one of the following forms:
#      123.123.1234
#      123-123-1234
#      123 123 1234
#      (123)-123-1234
#
class PhoneNumberValidator < ActiveModel::EachValidator
  
  #validate zipcode if country is US, else return zip
  def validate_each(record,attribute,value)
    unless value =~ /\A\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\Z/ || value == ""
      record.errors[attribute] << 'is not a valid phone number'
    end
  end
  
end
