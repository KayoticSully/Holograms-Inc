# EmailValidator.rb
# Holograms, Inc.
# Author: Shane Steinert
# Date created: Oct 14 2012
#
# This validator is used to validate that an input email is valid.
#
# This validator checks that an email address is of the form a@b.c
# where a is a string of at least one character [non-space, non-atsign]
#       b is a string of at least one character [non-space, non-atsign]
#       c is a string of at least one character [non-space, non-atsign]
#
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
      record.errors[attribute] << 'is not a valid email'
    end
  end
end