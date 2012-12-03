class HelpItem < ActiveRecord::Base
  attr_accessible :text, :title
  
  validates :text, :blank => true
  validates :title, :blank => true
end
