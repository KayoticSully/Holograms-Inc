class PhoneNumberValidator < ActiveModel::EachValidator
  
  #validate zipcode if country is US, else return zip
  def validate_each(record,attribute,value)
    unless value =~ /\A\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\Z/ || value == ""
      record.errors[attribute] << 'is not a valid phone number'
    end
  end
  
end
