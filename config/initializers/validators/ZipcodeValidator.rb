class ZipcodeValidator < ActiveModel::EachValidator
  
  #validate zipcode if country is US, else return zip
  def validate_each(record,attribute,value)
    unless value =~ /\A\d{5}(-\d{4})?\Z/
      record.errors[attribute] << 'is not a valid US zipcode'
    end
  end
  
end