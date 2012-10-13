# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Keyword.delete_all
open("#{Rails.root}/db/keyword_seed.csv") do |keywords|  
  keywords.read.each_line do |keyword|  
   # name = keyword.chomp.split("|")
    name = keyword.chomp
    Keyword.create!(:name => name)  
  end  
end

Product.delete_all  
open("#{Rails.root}/db/prod_seed.csv") do |products|  
  products.read.each_line do |product|  
    name, description, price, image, stock, public, weight, height, length, width = product.chomp.split("|")  
    Product.create!(:name => name, :description => description, :price => price,
                    :image => image, :stock => stock, :public => public,
                    :weight => weight, :height => height, :length => length,
                    :width => width)  
  end  
end

Group.delete_all
open("#{Rails.root}/db/group_seed.csv") do |groups|  
  groups.read.each_line do |group|  
    @keyword_name, @product_name = group.chomp.split("|")
     keyword_id = Keyword.find(:first, :conditions => "name='#@keyword_name'").id
     product_id = Product.find(:first, :conditions => "name='#@product_name'").id
    Group.create!(:keyword_id => keyword_id, :product_id => product_id)                  
  end  
end

