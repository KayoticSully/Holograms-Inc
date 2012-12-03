class BlankValidator < ActiveModel::EachValidator
  
  #validate state US
  def validate_each(record,attribute,value)
    unless value =~ /\w/
      record.errors[attribute] << "#{value} cannot be blank"
    end
  end
  
end