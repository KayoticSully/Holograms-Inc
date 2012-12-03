class Keyword < ActiveRecord::Base
  attr_accessible :name, :under, :products
  validates_uniqueness_of :name
  before_save :downcase_name
  
  
  has_many :groups
  has_many :products, :through => :groups
  validates :name, :blank => true
  
  def downcase_name
    self.name = self.name.downcase
  end
  
  def inspect
    name
  end
  
  def to_param
    return name.gsub(/\s+/, '_').downcase
  end
end
