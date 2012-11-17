class Sale < ActiveRecord::Base
  attr_accessible :end, :markdown, :name, :start
  
  has_many :products
  
  validates :markdown, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :only_integer => true }
  validates_presence_of :name, :markdown
  validates_datetime :end, :after => :start,
                     :after_message => 'must be after start time'
  validates_uniqueness_of :name
end
