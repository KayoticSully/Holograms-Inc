# ZipcodeValidator.rb
# Holograms, Inc.
# Author: Shane Steinert
# Date created: Oct 14 2012
#
# This validator is used to validate that an input zip code is valid.
#
# This validator checks that a zip code is a five-digit numeric value
# optionally followed by a dash and another four-digit numeric value
#
class ZipcodeValidator < ActiveModel::EachValidator
  
  #validate zipcode if country is US, else return zip
  def validate_each(record,attribute,value)
    unless value =~ /\A\d{5}(-\d{4})?\Z/
      record.errors[attribute] << 'is not a valid US zipcode'
    end
  end
  
end