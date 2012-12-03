class StateValidator < ActiveModel::EachValidator
  
  #validate state US
  def validate_each(record,attribute,value)
    unless value =~ /AL|AK|AR|AZ|CA|CO|CT|DC|DE|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MD|ME|MI|MN|MO|MS|MT|NC|ND|NE|NH|NJ|NM|NV|NY|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WI|WV|WY/
      record.errors[attribute] << "#{value} is not a valid US two-letter state code"
    end
  end
  
end